Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609DB6FB2
	for <mptcp@lists.linux.dev>; Wed, 29 Nov 2023 04:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/cFbBQS"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-da3b4b7c6bdso6063674276.2
        for <mptcp@lists.linux.dev>; Tue, 28 Nov 2023 20:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701232312; x=1701837112; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4tXNgnoYGwJYpXN38ri6WmhhTQm1dtuwIpWWq1snzs4=;
        b=L/cFbBQS8I3rTq5PxnHTobZF5rbUsTPnY6cDXnroti3WR6NYNYeBxor5httTMBPDqB
         x9ssbYW5IJLCFPfu1t19AdVinYKwAMLpXTFr2hqO0GLxqqfIg4CmiCk1V1STsmx6wz+6
         jUIjcWi7+z8xNM7G2eOMssdj7PKHf1HLGSL88qL+NxSZZCfVMTS9xBOumAvsAfe+IsrV
         iX/k16RW7V8QzS24oFjF8PFmUQA29oGkaFZIPsrfBVXNyXZXHtSP28dQRmOOvEP9c0dp
         3x8FkpeVirjEho96gkiMPSlvrTElJZjCy5UMUX6aiyM15pPlxcxIXaBA4xn1QUMKpD5+
         DYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701232312; x=1701837112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4tXNgnoYGwJYpXN38ri6WmhhTQm1dtuwIpWWq1snzs4=;
        b=XQPyIGHhCCXrZb1imbnLByGq9Z6yx+oILiw1rLvMTr1h1L2GXjwvpCxrWFgsJ3pKYa
         DRFzqcmXiPNiPhBlqHuI5Ven7AI+zlIgXhkxMGYSmYokUMESI0E/Y+kdQtzobi80SIhl
         MdDavnYu+O3GugOdG3a05MnKC8cCRkdVRcbSbcwiLfbVK+ITZm502SUJQrbx+18w6soK
         dL+07Ny+6BWQG8/6xFAjki+rEU3OzoeUWwAxiuaBxG4CpX/qsbLsAtSy0aZqsEiH6U2N
         sNoiMawt9BCoADEGfNFU3m8oNoEwnPDne2WHG6E/ii9HF5pSU4EEXChIUOGTlPNaB0UG
         96Ow==
X-Gm-Message-State: AOJu0YwX/ol/KGb/m7cnNA3Z2EftTZdYC3ihacm46Z1ZBRXVGZl+W+bV
	+gNg8JzDt28WswTCiNemSQ==
X-Google-Smtp-Source: AGHT+IEQ2RFtagdcJCJ7rZOYXHW4TNeCXO4tDWC0Jg6sIFQCYzehinmuf1w5ticIuLCReElVynzveg==
X-Received: by 2002:a25:74d7:0:b0:d9d:1b00:252a with SMTP id p206-20020a2574d7000000b00d9d1b00252amr17606110ybc.2.1701232312111;
        Tue, 28 Nov 2023 20:31:52 -0800 (PST)
Received: from [127.0.0.1] ([172.183.88.176])
        by smtp.gmail.com with ESMTPSA id d25-20020a0cb2d9000000b00677fb735738sm3242058qvf.34.2023.11.28.20.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 20:31:51 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <bfe28bf33329bf157f8b8f9ff49b398003c487cb.1701230012.git.geliang.tang@suse.com>
References:
 <bfe28bf33329bf157f8b8f9ff49b398003c487cb.1701230012.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: join: check CURRESTAB counters: Build
 Failure
Message-ID: <4c720e3d-071a-68a4-99ab-c2a3f86f2a50@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Nov 2023 04:31:51 +0000
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

  https://patchwork.kernel.=
org/project/mptcp/patch/bfe28bf33329bf157f8b8f9ff49b398003c487cb.1701230012=
.git.geliang.tang@suse.com/
  https://github.com/multipath-tcp/mptcp_net-ne=
xt/actions/runs/7027998325

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/bd08b7494c=
bb

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
