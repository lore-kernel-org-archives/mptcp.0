Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AC5A31
	for <mptcp@lists.linux.dev>; Thu,  9 Oct 2025 18:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760035734; cv=none; b=cnkiU+/Hv4fihoqlUETCTFyRAF4xc4xFTEqhmkMwLHh6b/MJ8a2bFV6hYuAMd7GJwNrRquRRbk8e5CxkQeZszY8cZK48hAfzPQPnLES8UCQd529iBL2DTi1merWcyJONQF5l/EAf7pnLVWdXESC3cPLDYRfy09uekZpUkCpjWuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760035734; c=relaxed/simple;
	bh=jeVHzIHas2hHrbHisQKBReyy71eLLMiNbpN3hkpXAX0=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=FUKbiseHvbZFZCcclmslE5Q8YoTVCR8nMl0rlKVakXWxCVb1IgGvaDJ6Azjvd5DiYFtOwQhuz5JzhDkn7Qsp6e36z05uRaBCbvs7GVyFgFKy+bJiS5Yep/rK8zdeqbW6foNthkdXWYaHfVc6JoaY8xOkrOFxcSNmgw4XSWNKjLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKC3jTG/; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKC3jTG/"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3327f8ed081so1706242a91.1
        for <mptcp@lists.linux.dev>; Thu, 09 Oct 2025 11:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760035732; x=1760640532; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55mnTUhaxMkVv0s5g14T29s3GhtlbzAjXwoCYJRBpcE=;
        b=lKC3jTG/Dg3EzyVU8jwwJJJ3MsjgsgZ5vVk/1wJ+SnPNW2q508O1a7SdfUIU+5iigW
         PM68xCXVMhnVj3L+G7CSM9HERbP8ZGdukgj5ao99uSGcKLTOxitND2qkBtwoVMRlIIgj
         M13U+Y3hW9wZue/oWXEjwrYeIu/AgcT99cPXvSJ1TW/EczIFJQtkOgnDFX2gPXxigKPh
         RGCD0uP6ysXwQPzbd0tWi24lVu1lGPRgBrzPWHcIn8206pppJ80r/s60GYgsiNQBeds4
         V4FeW+U9kInTEuhfOtXexLPfvs7jIRG7uvNHtIyMT5hCRLGCAisA/QLcWcg7r8gAuJFG
         Iogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760035732; x=1760640532;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=55mnTUhaxMkVv0s5g14T29s3GhtlbzAjXwoCYJRBpcE=;
        b=ZnGaAyCymGKb3bt3AMA2GxBsUoyPOfZTQhsdgf12amBcl/FBeTjWPRKqc5UPZvqriV
         qsZXt3BfYYNkSeahs4yb583+RQaech6nXdWv8h5lceoF3MaF9cJGrxIq3q/TRGzCE0r5
         vxAgYp1SgPUYS1t/t5zQSFzxSMrJ3AqFg1xC/rhRLQour4/F3GtIxn9aXTYUzlpZosxs
         LLiPIjHR5EKOtfB/IyzPwoiiIqRy1LMyeRII/lWMHVxxsxUEtrXHor/lWflGFc/JIoas
         ZxTimYrONlreGWw5Q4MnH50ewmH8OxWM7kByBb4rYEcaGetWtDapnsf3GHcQvMNHioVW
         vysA==
X-Gm-Message-State: AOJu0YwwFtIBZZ6MgVUmc9+PwJYZUyTlkGuGdymGNI0XXDAVUSEqRBb4
	pG8fb90T6H/GLQey7N8tYCkJ/rrjI3abiV1BpKoLHTB7YiLinpcf5K68LssQ
X-Gm-Gg: ASbGncuHS7v+buy/i2853SwRcCmrQomrUuSqqCS4JaHLdKvlcOnSY7ao490BZ+wbu6D
	DeDAzqg3FKsfqCy1QlAaKUW4w8wXwzvHJodT+oZA6d3jkaTWFA8w5Kw7CtvQpt3r/fThhmk+/0n
	XGdhzl0GJmnNC9ADZ2PK6z88KyNNXD0iA4O2zbOywlhvA9ca/3KwZ5PjAKRGCxsRuApWLJD/vt2
	K3BT6e+p8rgfm183JhUjDU4cU9+j5hGfvYu6jR1PK1OQP76SHxrEDGsiHSxjl6TQ6NJvtc0FTmP
	N4f1Dw7E2wy6UjpagcVbVO04R7vQr9KJSvNPqF8AbmnCxG2bsqsbm5U5O+jvBMXFFQb1PqyPYXn
	+/XxVQ3ls2QkoCZGWCGC1VnSXo9IXmvBpvns+2u7VLNBR9Tb5xsQBs6GyNoM=
X-Google-Smtp-Source: AGHT+IFXFy6FX2WiCDFZRiTK2DPlcQ+jV09X0q7ipCGNIyP3Ke9dxbIP3RZN8F2UtWUZNLZnDL7PUw==
X-Received: by 2002:a17:90b:1b07:b0:338:3cea:608e with SMTP id 98e67ed59e1d1-33b5138f734mr10565745a91.31.1760035731866;
        Thu, 09 Oct 2025 11:48:51 -0700 (PDT)
Received: from [127.0.0.1] ([52.234.40.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b5296d52esm3997784a91.2.2025.10.09.11.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 11:48:51 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20251009-bind-extra-listen-v1-0-5ad2077d77a9@kernel.org>
References: <20251009-bind-extra-listen-v1-0-5ad2077d77a9@kernel.org>
Subject: Re: [PATCH mptcp-next 0/2] selftests: mptcp: join: code dup + new
 'bind' tests
Message-ID: <3c69e3f7-6df6-694f-7978-e54cb7e0ed96@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Oct 2025 18:48:50 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_simult_flows =F0=9F=94=B4
- KVM Validation: normal (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/18384474239

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/cb24879849d8
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1009827


If there are some issues, you =
can reproduce them using the same environment as
the one used by the CI =
thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

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
