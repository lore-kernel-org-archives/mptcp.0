Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F0A1B040B
	for <mptcp@lists.linux.dev>; Tue, 23 Sep 2025 03:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758599845; cv=none; b=sVxz+NcM1Cx9drKPIG5hmPdz6iyqvEDrIpk/gnN/8ht5hzdN349dEEO9PqmhBeAT9uEdC4dg6bsXOW/rl+fuphepaSJQJMkn17us1h8QkhBEA7s/RXstJCcG4orBDSoMAc/xQecqrIIh1HitRbMz7wiFk/rXSNLfioWWyQ6L+8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758599845; c=relaxed/simple;
	bh=OE5bhlnGM9C9OPMoaUfEMeFo9xhEBTbYFRxf7g5Xjmw=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=jg8kO62tSpmsK0Yqh28S6hxQmSudsbRF5qHbJUdvASAVtB85jeBUg0e/DS0hLmOCeZUlYFBb/LCJ3JaBzYl2+eL/lmRdSq/A8pLSsm1LKGdlBaQYFpnoKj+I6qE7ADPYglmWNDoPOR10QLJjSYghub7EKB7HDLhTm88872EVFJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hC3sO8VU; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hC3sO8VU"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3fe48646d40so27808545ab.0
        for <mptcp@lists.linux.dev>; Mon, 22 Sep 2025 20:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758599843; x=1759204643; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZMFCO1gh8WlDXsiLMk6596fXFasrN4SsR8v0SccCU3Y=;
        b=hC3sO8VUevP62uMhtSEiAISM00ZRm6J2NVs7htbu0CZwQogf5zcH1RauAqp8SGbJqr
         EkuC2Qz8kB2AXmU1rQHGFDuM5Crc3rjFer1pSz2dNEOgZFKMPtMUAiii/o+s73eGBLz0
         TVUoxXO4nL5vIepzmdK2O6aTGwEy5Lv8qXwdAn9co2ZlRHaOKBY/13d50x4dUt05cZmX
         FtG5vNU90sEw9FXHAv8JxZcBKNhOYQSVvzNIuODKJ5r2RbaS1m9QQB31GmFhhMXoRHPD
         sKdz9OBKHPSIJvJ7azYCrNk55a+zx6IY7CmzqRRcwlNe57+0z5bwgJqRa7eZ2cjunpUs
         TIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758599843; x=1759204643;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZMFCO1gh8WlDXsiLMk6596fXFasrN4SsR8v0SccCU3Y=;
        b=iuw9RDL4jGWxt9xmqqKr0AqiCIsorWphRQlIAA2OZeXItmUrKWAE5A65EVtofRX5AE
         ipnxCqQvPP7Ajr1SMNjE5PQiUlNrCgNxyFGkzo+JPCKnqAJJoOY67/MQ0N5yTvwE7ni7
         CeEC4YhToPOQLxzZrr2Lz4zzeGmM3TWr9A5vANNlg7H/pTImvsHrhylM93BoCRi1TEny
         pHl/OYQ3mBAXCBrTa0dh8VQXNCeCFUzOCbKFYHePOL2NTMdpyx8dWFvy4XoZZLYzkLeO
         ldCpeIK09LIh8J4tVO59yF4VHJhc7A4KsFv51a09IF/3cUnbt1GdBfng8LZGGw7uODqL
         NlxQ==
X-Gm-Message-State: AOJu0Yx68zAWlW2WAYEEhf4saM4rsWF8hc8G74djFnwpdclUAE/ayX+F
	IMeC3qacGYu3/Vc2qf++kd676rI61HIuux2/puqFnavJ3/JRQZdJG2WBbHTF
X-Gm-Gg: ASbGncusfNEoyxNKOtp2jRTxitWEbvyPyisWJHWmdNNLiTne8WV4CG5zAQspWwqoaVn
	CbDhs+nBkg2n4IKwjwLk22uzRztF/9pWR7/AjPY72ZlgsbiyEiTtgciV5weW6ZwyPDnL/MSCcTs
	kMK5JdzATrV27Kr0SMnZMREPgxOVCi5mqWxu5++5gI1Nx1YEKPNniVtZP27ln637xXCMKDYMgGM
	127lUD67rpnMq/mAU4TJi/o74oDjcZFBSEsDQBvO4bFX4VzSSWdf/H8ZMUsfSlmo+KaYDPig4PB
	/jWGqasA8HRUENq2Qh9PzioPylozK9D+dl/gb1pxBxVRnEvJZCVUQgytN45qCR11FbWpXv/3vsH
	GakCi5Yz/S9B+X29A6RwSga8HjYQJdjfvGHs4
X-Google-Smtp-Source: AGHT+IEaH6ngQcNkqdNeo8so78Wx3GFwA2Miv/Pr15vPHafunApmogTo/xaRO2hJsfYolv8G4PEpPg==
X-Received: by 2002:a05:6e02:85:b0:425:849c:52fa with SMTP id e9e14a558f8ab-425849c5424mr8824975ab.15.1758599843407;
        Mon, 22 Sep 2025 20:57:23 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.216.55])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5586a4393c5sm2977719173.10.2025.09.22.20.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 20:57:22 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <092fc76415deb1b45da5bb691ef6069fbab7dd09.1758591744.git.tanggeliang@kylinos.cn>
References:
 <092fc76415deb1b45da5bb691ef6069fbab7dd09.1758591744.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next] selftests: mptcp: pm: fix pm_nl_ctl build
 errors with old glibc
Message-ID: <b3d3eef2-f18b-e0e4-7f7e-198c36ff3ba6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Sep 2025 03:57:21 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Critical: 83 Call Trace(s) - Critical: Global =
Timeout =E2=9D=8C
- KVM Validation: debug: Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/179336=
60640

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/cee2ecf788a3
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1005087


If there are some issues, you can reproduce them using =
the same environment as
the one used by the CI thanks to a docker image, e.=
g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" =
-w "${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.com/multipath-tcp/mptcp-upstream-virt=
me-docker


Please note that despite all the efforts that have been already=
 done to have a
stable tests suite when executed on a public CI like here, =
it is possible some
reported issues are not due to your modifications. =
Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
