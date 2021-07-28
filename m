Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992D772
	for <mptcp@lists.linux.dev>; Wed, 28 Jul 2021 16:53:53 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id gs8so5601365ejc.13
        for <mptcp@lists.linux.dev>; Wed, 28 Jul 2021 09:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=kviJHPZpsuPOQobVSRnbl8Oxh4UmCg6jtYJVdqJi6aA=;
        b=H09cbBMRXVqASosN/N5811iyWoMZM4AFjkJgjrQnTazVOqSvytnRg3OhSxN3BRkNG7
         +ulDn+7wlKQYs8hPQUt+iUKLG3CXORVYzXt18Whtd4dnYyiIs/WBdjUAqOE8zKYJTu61
         ACoodR2nnNuuKfgDC+IbNwO6HE0Kxn3r3TO7cZXLhoY/9CAI3O3gRLQwNCFE/m3bp4J9
         o4CKFUGwq8Ktm7RytcSah38U5WLy8NY0scAumPE2C7QQvJgsbnVStBJiALS4i1ll1cV6
         QCVpEMjXZRGYsgA+DjLxMWMTThU4oTp1mMT79HQrukFme738of+anFGRYJta0pWBzfiY
         6ycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=kviJHPZpsuPOQobVSRnbl8Oxh4UmCg6jtYJVdqJi6aA=;
        b=gxUQFAQMEPHKf+NaA913GiDcAAxFNbAMLHXx9Z5UDn3GNbU4X5sid7tmD45MM1mzvy
         987f2exnw77RZv5i7X+U5YdWICnsYoeU8tVzyB50y7JhpDFCROPNOItQqa34pmIb40yJ
         eSqNgtPAm/rj6DwsTbbw+5qbg3DczDBwKAlP3D7cjP0v2SH5AZ1YU3mkJ1XyzalFhdFy
         boPrBO3wg9E0bG/X8lvz5dAdQICAWBoKgaUfXmeHV0mf7KZ3UrqKmcAUYZ26/ScCl+Nf
         2azmP3iD56uQASlx2QM55WCyeQzQ8FcwJJS9oTvc8/W6SZmMrs66fhuqNQsHKuf6uQNh
         jUJA==
X-Gm-Message-State: AOAM531eSwUetiErffuvE5d7fqb4c0PPD6a8o1rSrhzTDMMtx4UVR2lr
	HQJl+tdUP+OzSps6A8FRI62hvuxYJUXLmw==
X-Google-Smtp-Source: ABdhPJw5tUU/mIoCYbIuFtd0KIfB66/IDlfNjYctq7foF4GM0TZCR7PHMMpArNq0l0UJmZ6UePgakg==
X-Received: by 2002:a17:907:f87:: with SMTP id kb7mr455744ejc.58.1627491231457;
        Wed, 28 Jul 2021 09:53:51 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:c852:afa0:c279:c071])
        by smtp.gmail.com with ESMTPSA id u4sm119789eds.88.2021.07.28.09.53.50
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 09:53:51 -0700 (PDT)
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Weekly meeting - 29 July 2021 15:00 UTC (8am PDT, 5pm CEST, 11pm CST)
Message-ID: <2f63dae1-38de-4432-3e8c-1305532c0302@tessares.net>
Date: Wed, 28 Jul 2021 18:53:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
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
https://annuel2.framapad.org/p/mptcp_upstreaming_20210729

Feel free to add/modify topics!

Anybody can join the meeting using Google Meet website/app/phone:
https://meet.google.com/edk-rkrk-vaj

See/Speak to you later!
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
