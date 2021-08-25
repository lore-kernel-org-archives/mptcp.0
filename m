Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580133FC2
	for <mptcp@lists.linux.dev>; Wed, 25 Aug 2021 15:22:02 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id g21so37499836edw.4
        for <mptcp@lists.linux.dev>; Wed, 25 Aug 2021 08:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=JIKqcnm3MTlQkGjVkiL6HzmvrdoCQBFHiLcF+PXOStA=;
        b=glaCqU5r2cdSbtYsNlVUD4aB3mmRDFndGUgVQplnyadzNoA4XXYfZHTfz4IwmFB5jJ
         FgbtIfG0otRYZ+l45em40Usij5C2pyp/v/zMSJbb9+ZXJ2VRPfuXJHe4LlufCwVQoQo9
         qOB1baCHN3oTgFY17J/PUCIdj8VLbCN0eQeuej8YQvPd4QZ+Il+cY5Xqurq1LzOFIvcl
         xM5sRXPkOj7Zjjp40GVLQ90/HYvH+fqKqRDxA8XJfrtxzx/ICCJg9eE0IrWc3hanupiP
         i/flyXvcfX0lbimT4sLZz531oXIA6SvJbbJeRInWrvRaf1UqDJMheYxePvvvfUP/88b9
         lzsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=JIKqcnm3MTlQkGjVkiL6HzmvrdoCQBFHiLcF+PXOStA=;
        b=r/6Y06z+zSx7Yi/iLIBnQ+d3KtAZyhUf2M09pUjF+QOQfFoKFM2kMxa9lqsUqSm8XP
         9gcQCPswl+4I7nqXK87BpPBAmGRLfXccXii+IotsHenvpRficUfHG6D9J/aaxNflj7p+
         Y08+W10c7xWszsoYdq5aku1z63cnt2aQcqkQ9zK8adDhKmT84T00xkPkq9RqSmYwwcwS
         z+VQSTHujaTjPVm4awaxDWJy7oOtiEsTbnKy4tVoDj3g+aFK5D7UVBHBCn+ZA0T73nHD
         AuJqWV2N86x8qx42KYZk9LNfrOmqMl/cattrTqZStYwrU99v3F2Ad8GghaO9c+xPxC5M
         NPJg==
X-Gm-Message-State: AOAM531ETKaLoSm2lWFmUEsa3G9kjSM5QZbY72k4R1TY0hZUeZCTfXLu
	g5TgJNYb1JDQ9ZWV8ZCIQApEdMfrG7z0Yqby
X-Google-Smtp-Source: ABdhPJy0snmKQhatQSt4J2Tk6vw0bK5qlgDjzhHPfvpi1lBOIeThoZM2cfhkdwBLqMTQCjtKYLyTdg==
X-Received: by 2002:a50:cdcb:: with SMTP id h11mr50449264edj.366.1629904921311;
        Wed, 25 Aug 2021 08:22:01 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net (94.105.103.227.dyn.edpnet.net. [94.105.103.227])
        by smtp.gmail.com with ESMTPSA id r28sm166643eda.84.2021.08.25.08.22.00
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 08:22:00 -0700 (PDT)
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Weekly meeting - 26 August 2021 15:00 UTC (8am PDT, 5pm CEST, 11pm
 CST)
Message-ID: <56ea8206-29aa-1fec-4dae-f1db714ff7a6@tessares.net>
Date: Wed, 25 Aug 2021 17:22:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
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
https://annuel2.framapad.org/p/mptcp_upstreaming_20210826

Feel free to add/modify topics!

Anybody can join the meeting using Google Meet website/app/phone:
https://meet.google.com/edk-rkrk-vaj

See/Speak to you later!
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
