Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35A170
	for <mptcp@lists.linux.dev>; Sat,  5 Jun 2021 09:02:01 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id og14so12848895ejc.5
        for <mptcp@lists.linux.dev>; Sat, 05 Jun 2021 02:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=nNxi5PDXWnyUQ5uLzaWeBAwF2EF84jv4PZusptP9tos=;
        b=1NY8gwKbq8dd6RUjzI4z7XEtqeLCQqDxqtXF70LiVI993ganiATdITlDVB88zdrykU
         MTjL9zMhmcQRCPvsUzETcbTU+2zDMfgnrjj7fxSGTxniYuyA7ocLdCewtrXA29Zes7+f
         R0wzXEBAviOq+jZ8jjmPtKDfOIJf/MKb7oG5jM0vc6FR1JX0rDyGj7x+M98ITyTHGjtb
         8ILSvndaQmgL2XYgOi1c5F2NOeuLputebHdHEM29KhnummFSEFIVr0Ki7jAR8lpphei0
         H69JazFzTHq5ONdFWP/R0FsVbIszL/eb+gE4lv4zpPlHW4mZW8/wlSQc9U28lXHdZktw
         i71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=nNxi5PDXWnyUQ5uLzaWeBAwF2EF84jv4PZusptP9tos=;
        b=dZ9lgo0y49t55QvPKVC4Lp8Sp6GKNHVjyFZ7Jy4ECuVjQNnUz+d34n2ik01i2ic0dI
         a2W1CHJcHg9seuIGGnh6IU4EnfjT7eHqs/LFSSIcaIOLgF6hm9YOkeBgXLxr66nZgLzd
         tb+VcyLOXHEIkSwPenQjcZqZzPHoL7p8rmbC/qjzGU53mqnKSkCFfceOruwfwV2w0GUd
         qsmpIlHU6uzKpu0xU9sAoscrxzOb/Asf4LuxTH3c5nKGFqXtWOOUzvVenCAWHOTbISoY
         FwJy4JEcVoIxgTblObjJiUv00Wr0wTBgAljF/fPys8xREcGVYB2vPJOQ5vl11CX56wp6
         fM+g==
X-Gm-Message-State: AOAM532+cm7MWlNknDjIe/VVEd96jvrYZbqpPPDd/ecs0VSWbNelGAV8
	Ln43IIsLDFdtz+9VYZToZSvSn0TOUC0MQBc5RVg=
X-Google-Smtp-Source: ABdhPJxvVlfWFea7LJTGQc68KQRML+feG6Bxt0XNA25SKR/kAMKhstqaobOl36qFcF6yMIQybOyQuA==
X-Received: by 2002:a17:906:489:: with SMTP id f9mr8107067eja.508.1622883720055;
        Sat, 05 Jun 2021 02:02:00 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:9baf:51f:dba1:e228])
        by smtp.gmail.com with ESMTPSA id cd4sm1517444ejb.104.2021.06.05.02.01.59
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Jun 2021 02:01:59 -0700 (PDT)
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: IRC: moving to Libera.Chat
Message-ID: <71bceb9e-cfc8-4577-5828-237fc66b753f@tessares.net>
Date: Sat, 5 Jun 2021 11:01:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hello everybody,

A short announcement: like many, we decided to stop using Freenode and
switch to Libera.Chat.

We support Libera Chat staff's decision to have created this alternate
network and we trust them.

You can now reach us on #mptcp on irc.libera.chat:6697


If you are interested by the development, please also join #mptcp-ci.

Our CI bots are reporting on this channel new tags, end of builds and
tests and new issues reported on Github.

For more details:

  https://github.com/multipath-tcp/mptcp_net-next/wiki/IRC

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
