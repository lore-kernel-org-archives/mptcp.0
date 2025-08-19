Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4D149620
	for <mptcp@lists.linux.dev>; Tue, 19 Aug 2025 07:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755590370; cv=none; b=OJLUNOWD2W5shzbJneb28jF/bjQiVcfSqIlQBDNt0la7GUnyWgThj48Xd8B31fmwbQLNmQ5fkKSpbjhkICvcLvMkwy3hJyvMPZtEC9XulExSZUrAnSwviuNQasBwxW22b0qWDpDEizYU09F6s7BpMiilhGYhRFUQqhab0Bs1tf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755590370; c=relaxed/simple;
	bh=Gv841X2ryM3u4Wg7ZTY3ljQAhAvVgxPNUCvuuOoJsw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=G8Ir2f2ba20sGmxG5m+ghL3ag4UekSf1oXFaUdY+7ryLqpVXEUPIfCWUbj4hiL10uB2vsHGkzk9KdKs/YGQoxKd+0N3AxNUDCT7PNBE6p4y1S001kmT3Bv4Fx3RFj5oL4kpkbUBfcNK9lfzfgAU0F3YPUXznU2dlLN8+Bgkyxyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QZCq+M6N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QZCq+M6N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755590367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XiiCLc5VirR2rJ0guYI5aqK7LUu+ontDZGJ1TXQMyJ4=;
	b=QZCq+M6NRWrAR+3nz1t+WRyxzxy5YoPGuFhghsmYApZk3A/FaQHDi0nOdqiy/84nCcWqjT
	AF10lrBibSQpozu5XKyWDRW/qMOpz8JNghQvUvYh/TNUFGL+EOGdTJSDWMwiZacKvl+2OB
	p1OwtWuBNdkocvk80WP//drYsiGxx4o=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-h7AlzecjN1WNt-_WzcYwEg-1; Tue, 19 Aug 2025 03:59:24 -0400
X-MC-Unique: h7AlzecjN1WNt-_WzcYwEg-1
X-Mimecast-MFC-AGG-ID: h7AlzecjN1WNt-_WzcYwEg_1755590364
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70a9289280dso108719186d6.2
        for <mptcp@lists.linux.dev>; Tue, 19 Aug 2025 00:59:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755590364; x=1756195164;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XiiCLc5VirR2rJ0guYI5aqK7LUu+ontDZGJ1TXQMyJ4=;
        b=hytwibXJcFYLikIuHWrhSM50KOpjutLgTfDAs7di9Y/hT1jVKB93WTn07aFvEu8F2i
         UdIylxEbuRMSRkniIgqmNK2/aB1+A0q6DY/KpQYGsaeXm4pTj7TEa4SHVSefJ36IOEmh
         YJd05bIHm/jzyUoemI/vOYUcujuuwKXY52vIMWUEF7jLdFZ+Sxu4Q2TK3i3tSm+zkUn8
         jMmn4AccBvzbq5Jeh/8ug1/dVOEdfR1YORx+PCkPKaCp6E/b/0TiAI5Cey2GU4aKqL//
         wY2mOIOz2J8bQuR/KyiIknpzolSNwLKsfhZ5T35vn6E2QRiCrh5j8Xc7pdAhGfpZQGwf
         riEw==
X-Gm-Message-State: AOJu0Yy/59C0AjpLoRgGqmNSfkT/XPWhCp2E8b1YIFQslZYeJeCLbxr2
	O6I35hdSSeSt6Pjrq1u8ymtAH6FrGszG6p8yNmHKBS9ct67EzNC6H2ZrCVGbtX5OA3VekBsmPSr
	mUyxh1f+Hn1jneV+9g4bgnu8woAAm4F6sKP7zKa/+VkWl6yxxpKmZYjGUr7Y6ZLer
X-Gm-Gg: ASbGncvtvySg1Jx6Amt8tTRSwpL6hT9V6a5dwu8U+A22bLH14LMs2hVefxXh2uqE3Av
	cFV276gB0xJY8ptL+8q4b8uKnD8ugp3PC/Q9crtvMuq0QAzculmaApJXDhQBg9ChFvCGdP9xCWs
	kNF6z9Om0haRjiksclL87Wysl7Y7QvSEXlSteLT6KI1Izy1koL0j6+tVYlFzHOMd3+AGZVKbzgA
	RIer7oNAAStvbtIB8CzdxtHC4dRguREkRETkuua4Ifh6AwpT0Ng+eB91L3+skcbCeqxONdPese9
	fsC+ovWM37gZE5OvGfGrMTeTwWpY8SyUcX+vaAlJ0U13b0aTIgnOyNypnRRk2ZLrrY2piFHsFLP
	sVmN/K/iLjm0=
X-Received: by 2002:ad4:5c42:0:b0:709:ee07:daaf with SMTP id 6a1803df08f44-70c35b75ed9mr19318656d6.19.1755590363623;
        Tue, 19 Aug 2025 00:59:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIUg9dIxIAEgvT/Tsz2EW7U0Gxdj86fCu5s4NdUgp1i87upN5vgF50Yvfb/v04IoXDzsPptQ==
X-Received: by 2002:ad4:5c42:0:b0:709:ee07:daaf with SMTP id 6a1803df08f44-70c35b75ed9mr19318446d6.19.1755590363018;
        Tue, 19 Aug 2025 00:59:23 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70bc70c95ebsm16399406d6.67.2025.08.19.00.59.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 00:59:22 -0700 (PDT)
Message-ID: <72c4948c-e90f-4c2c-a482-d8e8bc2327ea@redhat.com>
Date: Tue, 19 Aug 2025 09:59:20 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_Requesting_Help_about_submit_=E2=80=98=E2=80=99mptc?=
 =?UTF-8?Q?p=3A_cope_racing_subflow_creation_in_mptcp=5Frcv=5Fspace=5Fadjust?=
 =?UTF-8?B?4oCY4oCZ?=
To: "Yang, Zhi" <Zhi.Yang@windriver.com>
References: <DM4PR11MB54070B6357BD5BED8F7CB3869F30A@DM4PR11MB5407.namprd11.prod.outlook.com>
Cc: MPTCP Linux <mptcp@lists.linux.dev>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <DM4PR11MB54070B6357BD5BED8F7CB3869F30A@DM4PR11MB5407.namprd11.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LA7XVs-3i3IR_HFVCBJkbUnzWWMF1n7LsagINXHOXZE_1755590364
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Please avoid direct email messages. There is an mptcp-specific ML that
you should CC for this kind of questions. Adding it.

On 8/19/25 9:14 AM, Yang, Zhi wrote:
> |I am an engineer from Wind River and I want to backport the CVE(|_|
> CVE-2024-53122 <https://nvd.nist.gov/vuln/detail/CVE-2024-53122>|_|) to
> kernel v5.10 now.|
> U|pstream submit is below:|
> /_|https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/
> commit/?id=ce7356ae35943cc6494cc692e62d51a734062b7d <https://
> git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?
> id=ce7356ae35943cc6494cc692e62d51a734062b7d>|_/
> |But there is no function |/|tcp_can_send_ack|/| in kernel v5.10 for it
> was first added from commit fd8976790a6c1f ("mptcp: be careful on MPTCP-
> level ack") in v5.11-rc1.|
> |So I change |/|tcp_can_send_ack|/|to its latest defination in kernel
> v5.10 such as:|
> /|- tcp_cleanup_rbuf(ssk, 1);|/
> */+ if (tcp_can_send_ack(ssk))/*
> /+ tcp_cleanup_rbuf(ssk, 1);/
> |->|
> /|- tcp_cleanup_rbuf(ssk, 1);|/
> */+ if (!((1 << inet_sk_state_load(ssk)) &/*
> */(TCPF_SYN_SENT | TCPF_SYN_RECV | TCPF_TIME_WAIT | TCPF_CLOSE |
> TCPF_LISTEN)))/*
> /|+ tcp_cleanup_rbuf(ssk, 1);|/
> 
> |Can you tell me if It’s necessary to backport the fix, and if
> necessary, the modification is OK?|

I can't tell if the mentioned fix is necessary for you, because it
depends on a lot of factors: do you use 5.10 in production? do you have
mptcp enabled? do you have actual services using mptcp? If all the
replies to the above questions are 'yes', than likely the mentioned fix
is needed. But in such a case you will be much better off moving to a
(much newer) kernel. Or rebase the whole mptcp stack.

In any case the code above is IMHO a reasonable backport of the
mentioned fix.

/P

> 
> |Thank you for your time and looking forward to your reply!|


