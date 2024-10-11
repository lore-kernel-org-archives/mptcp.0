Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9200210C0B
	for <mptcp@lists.linux.dev>; Fri, 11 Oct 2024 09:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728640625; cv=none; b=H7Yl+lu45Yl6HCd4MI6u056j5EOKbHl5+tClfxqtdDOIzvTYhrk7NMj/CRhwJsnVjmcQeDAWqesgQqmnpAyV1uz61pXEOWD06RyXs1TYZdQFmad4SSZKB5KL93xbhrMVh9Jq3XT2C6k5cDcKQkE4kUng/sT7NZuD3ceqTBBCjEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728640625; c=relaxed/simple;
	bh=cziqYTFMPU7F7YJR4sjGySFBTP6JLdk5vbeayyobqT8=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=uFW6rYAMy30Oi5oGO+5/sFnSmuqRsOOA1eHtPG53aoCtTTNNDP3OqkYr3Uu4+Khq8U7WelygICbxbFzRSvT2Y4U2Pk1kdCl1KOoT4xut7FKjuRUITABn8EJwF9X0FOw6maOn6P4jKhfdUfNMffB9foIeAFEwmR7KkEoiT5OfcUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GesXkvuU; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GesXkvuU"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6cbd1ae26a6so14059926d6.1
        for <mptcp@lists.linux.dev>; Fri, 11 Oct 2024 02:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728640623; x=1729245423; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1FahU7HuZwoHYWWqDSZfh9z3e63tI4LRVqmga6AyrM=;
        b=GesXkvuUyeog0XLjDmnyrrl+dOYZf9w4Tuawzayv+XR9WxLymfBR2BO4SKHIZs1rvM
         VK5g535NCXdEl3v5H9rqyFajvt/LbYtnvpYA+I9icY+77V10EDmKt4ssc+V1rhrmMSq7
         S7F4XVxsDTIwh6p6dorikejjcMOHI6OzreOeHD0TqfFatL9vaYJPobsG9MNPenDs3cw4
         tyZb+62hkG5o9KPN5DcSKaohRfbeqa4sW7v76t/VQmtUk0Otwn7Sp4HY+3D0qqufP5UN
         QpZdNCHvx4ADahK1FPk7Rjb7TFNFI77fuNawcL37wgj+onIqp4HpGmat0DuPdzeaCn4t
         fnrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728640623; x=1729245423;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g1FahU7HuZwoHYWWqDSZfh9z3e63tI4LRVqmga6AyrM=;
        b=Iox5LTr02VHJAmzKzX9A0/YHvlm7tjoq8u6HYRP5GPnQzCyzKGO8rGOo5s0B9ZNx+v
         Kl6QD4yCvAELT1rBBcT9zUTpk8lqf3ONBqjNZcCIRHCQtt2k0S3pYq+sa2S8yclHE/NM
         DsbQI2LGD+zHaDa6tclkDXqRSMduccj+EhIvZKULlHILsh+oPKOr+r/z+camX1XdxEdB
         U2ywAiF0k5rPk219YIC3nmUZbbfA4Tv6mfsgaxfc2b2mNWdwp9cyUSuv2IRNKjBGb158
         q4tnbPG0nvzVaf9HJ5bru3NTuQ0+1+XAy3lzctJj1occnZn8Lz/n5CfLj7gsRcSVImTc
         gCkg==
X-Gm-Message-State: AOJu0YxwFmDabsZm1anjw6BgXZup0FcjQ8zA84Ep++huh7xCaSUXF3zZ
	4oImyknD3t12MHJb9WZGUCuVwIAF6PvKr2hC+LYZQ8BJLqe/b4gLB3Qj
X-Google-Smtp-Source: AGHT+IFYoOuTOKuS2iDNql0qZQ9zBPLnENsHKwvr2MilkWJ5cD5hW4+dyB10ed2VsURNpCqMJH31Fg==
X-Received: by 2002:a05:6214:5c49:b0:6cb:ec35:48a8 with SMTP id 6a1803df08f44-6cbeff3a0aemr34454626d6.7.1728640622635;
        Fri, 11 Oct 2024 02:57:02 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.121.20])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe85a5d5fsm14004806d6.11.2024.10.11.02.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 02:57:01 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1728638310.git.tanggeliang@kylinos.cn>
References: <cover.1728638310.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v4 00/11] use bpf_iter in bpf schedulers
Message-ID: <9caf6d2a-4f96-34bb-dfb1-7e24d6a5bf28@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Oct 2024 09:56:59 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://github.com/multipath-tcp/mptcp_=
net-next/actions/runs/11290149435

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/fb=
fdd224fa01
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D898148

Feel free to reply to this email if you cannot access logs=
, if you need
some support to fix the error, if this doesn't seem to be =
caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
