Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF0C1E505
	for <mptcp@lists.linux.dev>; Thu, 27 Mar 2025 06:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743057013; cv=none; b=ARuzRZmefiCRKMWuJV4G9dvUSiCEXaVIWCKErE9cx2S+ucEFhioJW37NvDYvkOacBCwQIGQJ3CWqjOv3zCsU+hMSTsS/gUBBzu3GkhjjIKUMmt+oCXYKB7n16Z/BcmI/BtX2hhUhWXF3ykedwnPYvWJiLpS4Dn1e9n/5MpZ14LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743057013; c=relaxed/simple;
	bh=zrw6ftz7pck77UABL+kTfomGYdIgLx49OVCdK/XrJ3g=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=g6l2TWni0Uia+42M7KW9j1AkRM/gKCnsd/P8OyIyS7TEuIFA5KBASNXHvziPCkRixZPvJOKNxpegsr5G7fYOI7tuMrS//96fycwhdKnzf8BI6BiyYXneivFiraKfi/X69VgJ1NO9RQOGT48Lzc/csQ1mabFtJq1GlbdGn7dOYyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cPzt7kdY; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPzt7kdY"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2c76a1b574cso160012fac.2
        for <mptcp@lists.linux.dev>; Wed, 26 Mar 2025 23:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743057009; x=1743661809; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MB/fxzYRtjp5uBdNRp0PE0FZ14VFCcV5V2do4tdYZ7s=;
        b=cPzt7kdYKfIECht4KBCjB8RVIoqr4OvXrwUq273StRfyMsWrrWCajDwMeCRKnXodWt
         FjXPpInfHBpAiV/mOHbdnT4ZUW/49BwYLNZcQLH8Cwifjz8NtZdj9aX3r8DaOUVXqS4e
         A6/+LRw3OhC+HFjR/9qcybSBVYilUH6ZchOFYRps3yzzj5hvZ0yB4YKKJ/KyJNjuygfM
         YFDPjLP28v8B4G5SgpDwBP8hIkU69ozZR+O7+2FoLqvu1vSK7OULXJ6lS1Y59ph30yLi
         R1Ggsal9HCgAfo2AhrUIlCdNKeauOl3CH7XUkRkzOSXfefOYcfndLoeZTXxOlhH0wEEy
         tZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743057009; x=1743661809;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MB/fxzYRtjp5uBdNRp0PE0FZ14VFCcV5V2do4tdYZ7s=;
        b=g7NqBNVW0VfFwKG7NY/JW8y7uD/0SGhDukiyK5rIOzBOoWeZTg5b7WOH3O/WmEatrE
         VaWHm9GmVmaS11QPnSm4LOY4V7jsYo7o6Xyzm0uAS4tSwG6qAbDtogEdg7wvCHMSpUdf
         jcMFr/egDBjR5WeBThSdl0ZCHI/Q1aSFdgwHqeTUUaCFv5I0/9mVjdka/WWv+eiHJ7I5
         WMcxT3+D+LU8Xc3n8hY4OLqorfL8MJR0WXDYM36raaDpAcC46FvlimO9U3N8eR4vxBkn
         ePu9eSQiCYa3ToqvnkmvPyUuvaD+6ldblkY7d2tutzfjZV/6irw6zEVd2+VZySn9tMKG
         ACvA==
X-Gm-Message-State: AOJu0YxcgApHC/pD3Lsvg3PlpcUHMB2dNx0vsfCNjIkIo3Grae+t+TpP
	9bb7ZqUABLlQ4AVNuKLYqTSQnFUrdBqjsFrluDUQMx/W5Md4cMZAa2e1ksk=
X-Gm-Gg: ASbGncupx3AjCoHL5VbpcCK5zWK5bP5e6JL5SNVi6ssS1AFZe3vzwE2TiSMBs+2zjZM
	HA8TZdlu06y3gAjY8M6pRhZ+RTdVJB+Cp6hkbl46T7QE+68TxVELwjr0hPGLwMitL95AGBaFedt
	iwJPxj3ImFh5Jk6qLwri7pgaMx/eG+Y9S8kNI9zUMkOmi4AUbOTb0GZ7BuNnH/iSyRla7pCSSVr
	Yhh6dOetuW7Rax27b9cO9MV3F3oXQVBexlzd+x/7FMyzMvIrCXwLvQTadFIksqKZma+TPSvhsav
	piEmOUjipz4F9K6GUxiyXKC0U9ciquJQXZXJaaThPryrqZFdBLMj+Ujomg==
X-Google-Smtp-Source: AGHT+IHuKz22QjhNj+IZ6UDE8YgDQMy5RJ7HDCQC9Gn2iWPolAfSX4g3aSLmpbvglDvxPEG34XIAzA==
X-Received: by 2002:a05:6870:b6a4:b0:2c2:c92a:579d with SMTP id 586e51a60fabf-2c8481b5232mr1383895fac.29.1743057009320;
        Wed, 26 Mar 2025 23:30:09 -0700 (PDT)
Received: from [127.0.0.1] ([23.98.188.112])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c77f05ec85sm3481857fac.32.2025.03.26.23.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 23:30:08 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1743054942.git.tanggeliang@kylinos.cn>
References: <cover.1743054942.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v5 0/7] BPF path manager, part 6
Message-ID: <ec54d83c-9221-a0e9-d4c7-2cd3c858bf80@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Mar 2025 06:30:07 +0000
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
net-next/actions/runs/14100178407

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/55=
c1c9f50291
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D947653

Feel free to reply to this email if you cannot access logs=
, if you need
some support to fix the error, if this doesn't seem to be =
caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
