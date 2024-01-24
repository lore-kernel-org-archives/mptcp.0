Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1803315B3
	for <mptcp@lists.linux.dev>; Wed, 24 Jan 2024 02:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706063587; cv=none; b=fmjY5BtsdFeYgAGKoVKvblkkE43NtD9G+eQA3qFA+mDqTE0FECKoVmb6IEs7LWxrZ3anV0ryM/DtewF4aheh+qUMmNLDsvjbJgZ1KeWNll0jp/5nNHyLsMSeIiRHQYy7ahN1A5xUB52qnQjYmiU+1pDN77oemPORPK7JFvJBBF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706063587; c=relaxed/simple;
	bh=cUgkyxdaQ2Zfx5vn2+S9oOO0MHn4LVPYLX8SYrIk1nY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Yk1qyGSVAs8ltlnk4V3jFxpcKTLlA3yHCbmF5dk0LY2AOgB0pnoDCWSZn436oNMND6DdGbisk2giDN1jag7dL1RIxrJ99l06G6LJ4cEIb+xqEeS0OZUZ8uwEybEwHoic6AS2+dvrFR5wmro062ACooYONP2zTtBHubha8vkcAh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+YjRbcs; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+YjRbcs"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-783137d8049so421476385a.2
        for <mptcp@lists.linux.dev>; Tue, 23 Jan 2024 18:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706063585; x=1706668385; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRPmr5iAa/RPX4DWPRBDNzuK4T0FBoUj2sYdP7DAHHo=;
        b=W+YjRbcsI9rtlVZN+V/HCVaeVvH7ddTsiO0Oc1EBH9JVSm3T4zFdl899cnXqbYU6Gg
         1fa3LXTpoJT1HftLl52vFVJmiUNXmY3CHfZAeMql87S2XtUf31FhFQDl98mz6M7OzdWA
         0DeALSvlRiHEEc34fV805IW9KcSVaceX0oKYi0ipy+V8Wgkjl5olN1+ughm/0Wm25X7N
         LsE9L3m1JTtRlKhatKw1VmwVNNNmpPwiNB6e4vmt/8eT0PI3wF0pWSV/TorM+sBm4JKb
         51bZAF9o3sBlVEmQd8SXRlxfOSkq6KlEn6jNcBS0mdGH09STjavmvZPpdNPTfRu594Ts
         Od0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706063585; x=1706668385;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HRPmr5iAa/RPX4DWPRBDNzuK4T0FBoUj2sYdP7DAHHo=;
        b=CLvpbqqCWrciss/PHQRXFPhLw8BlCT66YfZe6QhD+DJBwxj3vljeNK3PRNbcsDEYt7
         HQrxX+tgDkaTOFp/TvPkQ7zKU3WJfYVwprX5lALdmgWTh94iFQf2gP2SRXidOxw8EzqQ
         XDzNH9CkgFchl9keHJLdYb9NSeylQ3LZVEu+42tyzPEtEF/9/OIw2/vd/HYynbXFrGrR
         +gCOMWvJiLXiwi6UgEoRrQAyVbQZ3jD7lKRyOFWfcQZzAC3YDWFbWxYOAhM9ckCxFhEn
         6B+0Rzl4WRjxe09dVXcqSStTsTR5dzRbbqdfESbWa6eTd4TV+P9nwtknxHMiF/32yHpR
         jV8A==
X-Gm-Message-State: AOJu0YwPaPU8KL5v8yNpO6r2BmwUEhXNvWHAqPKeXe277444hlypQnlq
	B1g8koTL+VK/EhEGKJ7RlVpMxLrNSQRvQ/FD8FQ3BHXQo8Eccmw=
X-Google-Smtp-Source: AGHT+IGjuXKyCKZUur7eyijtkTCKMdDX213kNDEkkfxSmzR+2h8fd/B9FJV/GPQrbo+35IOdKxuJAg==
X-Received: by 2002:a05:620a:22d6:b0:781:d911:7869 with SMTP id o22-20020a05620a22d600b00781d9117869mr6900447qki.111.1706063584945;
        Tue, 23 Jan 2024 18:33:04 -0800 (PST)
Received: from [127.0.0.1] ([20.55.223.227])
        by smtp.gmail.com with ESMTPSA id t15-20020a05620a034f00b0078397c1fb9esm3098730qkm.102.2024.01.23.18.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 18:33:04 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <35875ef9cb7194563b580e14c71cc8cb065f846c.1706043786.git.pabeni@redhat.com>
References:
 <35875ef9cb7194563b580e14c71cc8cb065f846c.1706043786.git.pabeni@redhat.com>
Subject: Re: mptcp: fix data re-injection from stale subflow: Tests Results
Message-ID: <d7e2563f-bf32-758d-793e-19370552bf71@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jan 2024 02:33:04 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Critical: 1 Call Trace(s) =E2=9D=8C:
  - Task: https://cirrus-ci.=
com/task/6638955139956736
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6638955139956736/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Critical: 1 Call Trace(s) =E2=9D=8C:
  - Task: https://cirrus-ci.=
com/task/4598261558804480
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4598261558804480/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/333cd7ebfec0


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 Core)
