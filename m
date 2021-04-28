Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAB72F80
	for <mptcp@lists.linux.dev>; Wed, 28 Apr 2021 15:53:25 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id a4so2009466ejk.1
        for <mptcp@lists.linux.dev>; Wed, 28 Apr 2021 08:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=NnMgDSeeKlBPycznEFuYSzWGxh/ZaGHgfx8VeVRf0pY=;
        b=LxAgykoThACN9AG9CY9lIlIfq8WVPidAfZZPmc05UspbRBFG5NB1fPKqBX87D1eXPj
         uE1l/mte8Vf6uXkYa+KhsaBZY2YkAwvW/mLHzn7LbjLY64BC03h//nahHVzwy3EZgdpe
         yC2aR9/8LfAVl86J7UI3o/OXwUrWHfYMs9rat3kciW/b6xRVvcv0/puvGR075zpqzWwS
         F1Zvg4lteAcMY2/IhPhupa3oWanCO8O2WViQZ864QWR6lvXPS7lT7GnSED46+axf7Ia6
         D2K/mk5PljlcCAYpChWYwjS8vNP1jE12AOBEM2SzDchtzuMfsKu1KdT5VQKZeBTJrDDR
         nFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=NnMgDSeeKlBPycznEFuYSzWGxh/ZaGHgfx8VeVRf0pY=;
        b=XeyFDsltvkebftkhobm3Gu6wjPwkeYDlJyKGCImeDNGmxVrdsOyrZOFyjib1vefgao
         xfsR5uFOYdcI1OY17lK3yFi8rjtMHlK06AtabVWs/ZRjjCr3LkgYotcbPhEfyWNj+CZj
         69+r0cRzMLJ4QYqXbHO5yXKrBITB8TTR7Od4KeA/bOtJuSKcdp42wNrceaFH3bShOKJR
         LdSe/uYyBkHuLj8izDriC9PsKhuW0v71SQfteBMJMecgy4MLzdGPdclR0ILTn95N/7Qx
         AHqyFE2NEkFD54dt5/2b0SwQ9YnDsHCkgm9ZPSH0QFRhs0xj15CifeM1Yk2wsinXE8RF
         BpKg==
X-Gm-Message-State: AOAM531UYNcX4aTcDmunUqBSSyt7Ab1ZhrjFE++EhVaevwAJzwfP+8+Q
	75Qe/pe96fEv8qCg1QRBqaoki8hhIsbAP9D+VQDjmg==
X-Google-Smtp-Source: ABdhPJwBDBRND3yIbrl3jtn9okITPXgu9P7blaP9ue1/8SefaQWNhsUafaxsyfRoOb7AfxRORnTLpg==
X-Received: by 2002:a17:906:3a94:: with SMTP id y20mr29279975ejd.35.1619625203567;
        Wed, 28 Apr 2021 08:53:23 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([185.156.172.168])
        by smtp.gmail.com with ESMTPSA id i4sm164597ejv.58.2021.04.28.08.53.23
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Apr 2021 08:53:23 -0700 (PDT)
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Weekly meeting - 29 April 2021 15:00 UTC (8am PDT, 5pm CEST, 11pm
 CST)
Message-ID: <e347108d-4b83-18f7-6192-30585225ec8c@tessares.net>
Date: Wed, 28 Apr 2021 17:53:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hello everybody!

Our public MPTCP upstreaming weekly web conference is scheduled for
tomorrow.

The list of topics is available here:
https://annuel2.framapad.org/p/mptcp_upstreaming_20210429

Feel free to add/modify topics!

Anybody can join the meeting using Google Meet website/app/phone:
https://meet.google.com/edk-rkrk-vaj

See/Speak to you tomorrow!
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
