Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4230EC0
	for <mptcp@lists.linux.dev>; Thu,  7 Nov 2024 04:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730955154; cv=none; b=r2xzVTvYRRK0DStW5CDppsEM0257hSAxNIzL10JhwNphO6PYWOghOXobQuiAyRRsvSsK/aBVRl8dmpgxD1nU+hAur0gR+qPpbECY2EgNFjM4izhesZE69lt7hslTlBbC6Wl9iMQXdfeSX8X3VP9uMgdlqsVKwb7bJQ9V/59jhqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730955154; c=relaxed/simple;
	bh=E/337d8022s5Hi8FEubA3mxVeQM7bs5Cw4g3/gyNmfk=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=ukR1ow9oLTfju+ppFtH9369FJFpt8l4yBOPLwpdBp9EIv9VF+Dt78dJDV4/0Hb9XTOZCFkwzJSw0kpaE3xAZYy1cfHfkqvGfEBbNlgmSo4o3LxeIH/O5MiMW5F+pZI4rU05U5sUz2e1ZyqccQlFD8rTqyqZx2nmGs7j3N7YpH1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMeZv3qL; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMeZv3qL"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-855eeff6448so236800241.0
        for <mptcp@lists.linux.dev>; Wed, 06 Nov 2024 20:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730955151; x=1731559951; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pbPg/RdunmSTtVHjGfR5zMqtuu67x/iM8NJvAapIsJA=;
        b=NMeZv3qLkIdBPBqsIzrYswVdoV/Cumf2O/MRI9MwDZ2yqpKm/jSfvU3LUveBHxx1az
         RRAnITRJvqFkJlOrOochpubRePXyVjDByyuWgo7wQxnMTqQb+R9pw5RMtQM3+mO7vg41
         ZvrlgZOUV9r+Lx6+Qnxsbp1c9XGOZun6RshdOG9WNStCO7KCbeVegyDqiYSgtgDDfSQL
         Slkuq3KZGs3YEvvu321u86AFTgnQPXZjsW8rqXkFsxvbnSADbR0XoS9baseg0wTXV7cn
         iBUCTvjjYaA3eu985o58/1Ju3b/IBleNY+V2RQzGRfjLUeip95jPbxkdLN0oa8RbTihw
         MM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730955151; x=1731559951;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pbPg/RdunmSTtVHjGfR5zMqtuu67x/iM8NJvAapIsJA=;
        b=ZB8Gtjd8Rmi1Et81878XLiWrZzvcJsaqEKdpnQNayUTCYRIZp7mcC6w4C+O29U1G3g
         mUDrn83bNaILCd2FenW+LeF0BFLUP1ElIHcADTQnQ478B8RWVi2FiDv+o672fcen36Hi
         kMMz4wFwbTLzVAkc2dkboIZ/EmdQF6UQ/s9rURrX+mZ5M5Iy8STK2dLgt4Ef/ktJQDFW
         s15v0rTGVqL0CF7lS8hpGTv83TPJ0OUN+LaYCo0KCyPT4KnYGps8QbuGF9QwgcnUhvv3
         bYvuCAOY/f8OV+3IbLHushJ4asYBbi1vLm7TI3ldC1Xf9Un4j+RNuryf1Q7N8uJhsVBP
         wrTg==
X-Gm-Message-State: AOJu0YxYvxMTOTZNo+jFEueUp9vjnzmxAN7a+26pjhCH02HiD+hG9Rcj
	YumquEQiT8vrK0qKw0hUANcje5lyaTJ/lmekEOmUIeaO03Z2sNoKfR7o
X-Google-Smtp-Source: AGHT+IFLmOuXKKTBIBqoNLvseMO00H+TtOwuM8yHNJurVlcydYWZFZH94OPjJ0nDf83EHzZvFS85CQ==
X-Received: by 2002:a05:6102:e06:b0:4a9:5d96:949b with SMTP id ada2fe7eead31-4a962def293mr20838689137.12.1730955151313;
        Wed, 06 Nov 2024 20:52:31 -0800 (PST)
Received: from [127.0.0.1] ([74.249.14.218])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d396630f80sm3254226d6.103.2024.11.06.20.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 20:52:30 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1730953242.git.tanggeliang@kylinos.cn>
References: <cover.1730953242.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v3 0/5] add mptcp_address bpf_iter
Message-ID: <3530a28f-83cc-a267-6cee-3f9a698d70b5@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 Nov 2024 04:52:29 +0000
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
net-next/actions/runs/11716784018

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/0c=
f3c0bfb619
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D907195

Feel free to reply to this email if you cannot access logs=
, if you need
some support to fix the error, if this doesn't seem to be =
caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
