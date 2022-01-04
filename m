Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76271168
	for <mptcp@lists.linux.dev>; Tue,  4 Jan 2022 16:04:10 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id o6so150393729edc.4
        for <mptcp@lists.linux.dev>; Tue, 04 Jan 2022 08:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:content-transfer-encoding;
        bh=QHXHvPtSEex0zbw3b/99tvmoD4AC0r8CXJNFL0SJ/ag=;
        b=hTLsk+YqjL7RTFDtvlcU3lBPdQjuwWcor7A9gaR7LAjFOySf/38d9pfUYtfmKJL7X6
         hK5dsiHoTDEVHHhCpKjjQoeUh/Vo8EqNpru+I8KqmnRtHViHEhsuQyk4ubu+p7laAbyB
         WEw/HuAYnVDJNBjJXqcb3Xd+gUWaYxdQUHjiCa9Zx4S4jC2s5C31Ggi1GnEEWVDF8JUC
         u2BUDlFo+i7MVqXLwppgyHVFd84K7HuuIy0ykZGebvik7ugD3fws8Fli/k5CsAVY/1Ng
         exLFBBrfbRK8lK3THRjZXoRQQar4gSZ2gaB44OktVK58FDhUspKklTj98B26mkqNgNTc
         guFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=QHXHvPtSEex0zbw3b/99tvmoD4AC0r8CXJNFL0SJ/ag=;
        b=BeCWHpGfD8dwbVn281I/ZvZrSYruVbTb9HT7w9wZoIF3hL92CIDlSiYZBuyJdCQ2ry
         COJM5rl9/gOtersBC49dgJpck2nsOeXn5v6EL2Ns7f4jU6gjeD90vsmd0UHYz/mf4Jik
         4dDuW2+zddaD4zQsR7r0ZEdpf/RCMVP6ATIXER0DlYN/Aiui38yPo2EnwXmststkL7w2
         +EXltPO4AKRxJ/oh/mP65HGIy43jspikC4XRuaBt8/t0XMpC56zHeE6Igh4M4A7hE7DM
         IVYa+PqDDP2SfupWUuo5nstDDl5/T12b+aSydm+Zbg5AAmz21P323/ATiHHRRo4gSIjG
         ZE3g==
X-Gm-Message-State: AOAM5334f20dCdZiq5PRuvzwzP0ggI0Q9+u3mpw84j1hN+wouNBgud+R
	8iX1BS701AOuIuQfcrz0Kb2xH2WecH47QNNC
X-Google-Smtp-Source: ABdhPJzCFUs7JogKFbCnL41Rw294W2rUJNhEQUCrAY39h6Dfslj2VOPySFcBesfsEi52hh/vWu1RAg==
X-Received: by 2002:a17:906:6a03:: with SMTP id qw3mr41208495ejc.128.1641312248198;
        Tue, 04 Jan 2022 08:04:08 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:eb62:5355:d611:125? ([2a02:578:8593:1200:eb62:5355:d611:125])
        by smtp.gmail.com with ESMTPSA id t9sm14888512edd.94.2022.01.04.08.04.07
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 08:04:07 -0800 (PST)
Message-ID: <263e8ee3-246a-8cef-02c6-08ce6f34e2fd@tessares.net>
Date: Tue, 4 Jan 2022 17:04:07 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-GB
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Weekly meeting - 5 January 2022 16:00 UTC (8am PST, 5pm CET, 12am
 CST)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello everybody!

Happy New Year!

Our public MPTCP upstreaming weekly web conference is scheduled for
*tomorrow and not on Thursday as usual*.
(the 6/1 is a day off in some countries where pineapples are forbidden
on pizzas...)

The list of topics is available here:
https://annuel2.framapad.org/p/mptcp_upstreaming_20220105

Feel free to add/modify topics!

Anybody can join the meeting using Google Meet website/app/phone:
https://meet.google.com/edk-rkrk-vaj

See/Speak to you later!
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
