function treTrattiPlot(tt,x,v,a,stringa)

    plot(tt,x,  tt,v, tt, a,[tt(1) tt(end)], [0 0],'k') % plot law of motion
    legend('s','v','a')
    title(['Motion law - 3 steps - ' stringa])
    grid on

end

