Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6711E492
	for <mptcp@lists.linux.dev>; Wed, 13 Nov 2024 19:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731527560; cv=none; b=sPyBkDIc4gs9Z1umhYPEQJS0NmuU/Qqp8kOuKfwXaJFzY6PcvJCRHTzmwr7LpdGIuoaBWmPXLw48rV+m4ZURZhfsMeI0iS4DxNs4sU5opMLupuO+mOCZu6TUOxt0VIW52XJqacWgYD7+evdwVojqDLg6EX+wnSEngKas194x7og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731527560; c=relaxed/simple;
	bh=00iD0FfzRaNixzbqVdy8TRh2sCCMJgRMwDmmu0mCGoc=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=ZL26eFmQlLZUHlDPZUjJHbZigaN6Zb8PWc9/1w9rD+73J4MlX/iI3bnps1+//7VnM85RRTyDvyFCFSBKvn5LokgKFBzHjAxcQGeBf76k9+6vftbBEMgk+nJsB13UvDzXHZ+a1cwuRBgGSzBGZEdgZu+QUbXVUQ496ddvseGhwWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kexljjXx; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kexljjXx"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-211a4682fcaso27167655ad.2
        for <mptcp@lists.linux.dev>; Wed, 13 Nov 2024 11:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731527558; x=1732132358; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Crmi6jg6uvKVXuz/Rlq09ip0OPXGOnPrQO87RwTNIL4=;
        b=kexljjXx7O+CANyrJEOpt9PMBQ1f5Z61+VW8i02U6dtgy1IHcfAM1VfIl5BKKeiZc/
         GtKQtEi8r/mWVUlDifCiCdW2tkhZYnkvhJ6KhQi6fY3BsZmbG3xxl65gnmvARsEelPbe
         aJWkV/6oLHmqTs906GK6cF5gmWWMn0QI9cKArBoqPtBB/fAfOXoASOI+BxOkS1EnntTB
         zKP8QPfnsL80T69RqQs1FQyeC0nK/x9X+efcVbVTgrQfWBhOypFWZvG0LCCnUmYl5E8u
         tKt7ABagv8+LQY4rCzFGqiIS54rEsuDs6dVmVOX3vKzQLVVq7K6m2/bYPOhtZyuOT695
         ZLJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731527558; x=1732132358;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Crmi6jg6uvKVXuz/Rlq09ip0OPXGOnPrQO87RwTNIL4=;
        b=lbCeRX8lCjo/hbioMfxQzjP2ofYQf04Ihao1sZ1x+gzVAg8hyObc4rRZsHiRAiOay4
         7oGqIGWSDGtnHP25KeZYmzFAxLY1ycvvFS/LKNx8et1eV0/uNGN/WMtWyG6TBhkN4yDe
         2AOeAqeXImkbph5Eoermh8CAlWxBDBL2Y8xKTmQnbNJ4Bi3rgp0NBuecGXwUgzBejuhr
         ZlKUDt8MvI+4S6QWxQ9oaixw8pPfsC0cVoPc1062G2y7djrfKauCDXAF1z0khnz7h/Ki
         ISXRPWpwmT0fT3guYaYGU2PXZugERPrTOvjVbCSdlaVV0SKSKb2tVPFaWNquQootcRmE
         hdMw==
X-Gm-Message-State: AOJu0YwzNODEvEGreoFVdToDLm1wfm48XOWMgZDsacuoGK4SO0zeYl48
	XpxKM+SpnLy4xQBt9nPKdVqzVyfMjg2m0Wg+lnjduvBZQoyFthQ=
X-Google-Smtp-Source: AGHT+IFJr2uLUGRv2Td4XS9FItivDTXpZ1d3RpxeWGJXA3HnqpByn19UYJyMdw5EPqgCPoNQNLgtkA==
X-Received: by 2002:a17:903:2308:b0:20c:d18c:1704 with SMTP id d9443c01a7336-21183528de2mr287000485ad.23.1731527558195;
        Wed, 13 Nov 2024 11:52:38 -0800 (PST)
Received: from [127.0.0.1] ([20.172.17.180])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e58e4fsm111401155ad.203.2024.11.13.11.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 11:52:37 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20241113-tcp-md5-diag-prep-v2-0-00a2a7feb1fa@gmail.com>
References: <20241113-tcp-md5-diag-prep-v2-0-00a2a7feb1fa@gmail.com>
Subject: Re: [PATCH net v2 0/5] Make TCP-MD5-diag slightly less broken
Message-ID: <01ff0051-616a-f196-50d6-fae3b5244f5a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 Nov 2024 19:52:37 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Dmitry,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/11823966620

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/0952c60a2572
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D909394


If there are some issues, you can reproduce them using the same =
environment as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
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
