Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2E25F
	for <mptcp@lists.linux.dev>; Wed, 31 Mar 2021 15:08:21 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id l18so22741173edc.9
        for <mptcp@lists.linux.dev>; Wed, 31 Mar 2021 08:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Mm+HsBXofOHVZQ/7h0FLzpMd4csjwCXqp2Y1l1ASpIY=;
        b=JPKqzhNYTu2QQaS6ajKthiP+dZJg32RbqshBy6EYHiIgjKcNBw3Y/WtLdYExZPgBMx
         vwtDN5kqbeKIK8vUP7BAtFCDo9lsW1jTo9IUtK4BW4MmNhyhQRYcIk4A4TVEu8NvvsZw
         FhjAUlE/NsD4+H1oJltSGbVFzOypU3KoDS3QjH8V3tiX3ydy/7+bIJFCZFk3xj61s8j/
         CXnQFuPFNLQcYKZAFRgcnyOyZE+OeQAxqDW+/Mpn0n66EdPo81OndBx1WwD3r1ujFb9r
         wybb0px9JT7kbauPML2dyL5pOo3I/0qz0sHa4bfV2VhQLq4gOk9W6KuhWZf1iqI/thHP
         dmnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Mm+HsBXofOHVZQ/7h0FLzpMd4csjwCXqp2Y1l1ASpIY=;
        b=CMvvxXL/HVphm/oZQQNFre0nWOW0skZV7b8ng/QRcfLoe4FMLWBB8Ph0N/qDw5wsRC
         NxlISUF/Qu+cntdCL4N7wj5pM+MLo9nnw4kiFD55YT5k+j4l/N7dM/4b4PXII6TGU3zi
         p7H9SeJCw6gO3BcIFIFwygWSwTDR1bcJfkR5GZhACLCys5St9ZscwAqcc0rLFwYDiDan
         sK/FClVeLevXevsEtIhSsKorDegJmjlYx0fFn87nZA8UqacbaPac2pr+cJAWCRorfMAm
         oL62rsRGITiD+JbKD0SB2UwTUyhVD1Qf4hZik56RqFtA3xNYZhR2tSrcuHffZwcA7SiT
         dx4g==
X-Gm-Message-State: AOAM531x1JpOKNecZ/IylM/a7SDx5MCsW+DsyOG2vQNfgr5wWZG05GLN
	TUTw4F9M7pO6RSjV2sNL4NXVYQpFz4xD+wLp
X-Google-Smtp-Source: ABdhPJxwiG+12nwlswTPmi99oEmktmhN3R8zsvTmKxbD+DMK1Q1ZfDRs4aB1pgtx03p9/SGDEhNPHw==
X-Received: by 2002:a50:f391:: with SMTP id g17mr4295219edm.26.1617203300131;
        Wed, 31 Mar 2021 08:08:20 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:27e7:ce28:d7fb:3bf7])
        by smtp.gmail.com with ESMTPSA id r13sm1843469edy.3.2021.03.31.08.08.19
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 08:08:19 -0700 (PDT)
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Weekly meeting - 1 April 2021 15:00 UTC (8am PDT, /!\ 5pm CEST, 11pm
 CST)
Message-ID: <09218f72-4960-1711-0e46-35db96ca3d73@tessares.net>
Date: Wed, 31 Mar 2021 17:08:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hello everybody!

Our public MPTCP upstreaming weekly web conference is scheduled for
tomorrow.

/!\ In Central Europe, it will be back at 5pm /!\

The list of topics is available here:
https://annuel2.framapad.org/p/mptcp_upstreaming_20210401

Feel free to add/modify topics!

Anybody can join the meeting using Google Meet website/app/phone:
https://meet.google.com/edk-rkrk-vaj

See/Speak to you tomorrow!
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
