Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFA017E8EF
	for <mptcp@lists.linux.dev>; Mon, 27 May 2024 22:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716848595; cv=none; b=GiTI3/P9y6syuANkZPYFFe29jNQjEaNJMoqmOBUIHJKCJnb3+j4vmlwY6GKXc5ifAsY0Gmi1yc9rgnpBeaYy1vjpHNdcaHCXlISCPLye/GmVVxLyER6o8NojyYMjgQZCQupL/sRBVd9OIaxFPCkRdpAUW5euTLGU2jQbVYQzeQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716848595; c=relaxed/simple;
	bh=SedFj9PgmKESWHlYdtsXPwnyNlan6pISANI6JryO2pI=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=U3Xj0ANaWfYzJZ/DWd7BFryQnnp9KYIKnpj9UldzCWPrvECjUczgoISg2LpNh9+En6Jx07kIe76c/SrF4bXHU/A20KPamRuutFhih/ZfPCp5epHMwufwB79I0Km6Oyq3ZuQb2x2cq5n2ieYzB4UZHRpp51HNh5wRM6BlL+/Xaf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mv5gGLOY; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mv5gGLOY"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-794c1a4e5f7so19051485a.1
        for <mptcp@lists.linux.dev>; Mon, 27 May 2024 15:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716848593; x=1717453393; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrjTL0uOuSwvLoyN8rAqTPUMJoUyXzAGW+KCNOsgHn0=;
        b=Mv5gGLOYro0k6gN+JLojy2bDqN902SRvf+q85KIXn5GHz+txppfqBnd3Gm/XI6Nq3y
         bsIovrMIX7W5lWMGjZxUENfp1YuC+VTossDur38MvQhouIzq0EMek9jlefac4oYsmd4a
         +S5ZNnhZNr7BiRTJAzfABtApg1hKX1baH0HMnlcWiwe5toUR2iAlyL3OfttcJFO5ToUO
         py+VvJhJAPCx+B+2MrNTDm6PPqd0HGLwulZrRNwk4K2f3uVJksAXqZxpmkXDjyd8a4jb
         mYXKUXikzVIzH1HOwhBskBnyW89zz5cKerOnD9I4uHhNQrAOmk4sURVOClMszOeGkC/H
         M/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716848593; x=1717453393;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mrjTL0uOuSwvLoyN8rAqTPUMJoUyXzAGW+KCNOsgHn0=;
        b=lbVLXxh2LvkkFTSnM0k2kPulRQKq9XOJqZmgxXWNcS6AtwWtEYn1sTVhZg5T7AcIpv
         rRhtcKi0ehhkh871lQAm2Vi9ZH+TM9l9kJzreDXiaCpMdYkeM/0gK6LHqNQHfbolwAr7
         ypqGm7Strkfom4wcqTY/LDy/8xGB/3jcgYeRboyQeB2mKEoNrkCmn//mtYEih//7M2x3
         1sSeVT96s0tYaucldIhuG/LlJOhsUznS/zXaR+EgS8Yhuvxh6+VZf9BnrjbKNyn/cyBf
         Yp5hQzpjJueb6AG/K44oVJbRFqB2vZMwk532752sl7dxDi5fjnTurh5DBKJSwnIc19qA
         DvNw==
X-Gm-Message-State: AOJu0YyFELAcz4cDHRDLWsyQuwfBvCb7L7Ru/XZj6NcxzGnrdjwn/NPi
	Uvsd/WHVe9wRgynOhmPK6L0JovOnbMdIcu/WIpCIQ767B7o7xA8=
X-Google-Smtp-Source: AGHT+IFbHZXh9EtJnsJ5moWg4f4RPUOKfN3Ho/v7ZPTuYvwqQ3XQ0Aj3fPcJMoBJAoNwfJr+zbxjPQ==
X-Received: by 2002:a05:620a:1a0c:b0:792:956f:6b93 with SMTP id af79cd13be357-794ab0f8ab0mr1281995085a.57.1716848593351;
        Mon, 27 May 2024 15:23:13 -0700 (PDT)
Received: from [127.0.0.1] ([74.249.14.179])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abcd9673sm326101685a.55.2024.05.27.15.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 15:23:12 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240527213641.299458-1-jhubbard@nvidia.com>
References: <20240527213641.299458-1-jhubbard@nvidia.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v2=5D_selftests/net=3A_su?=
 =?UTF-8?Q?ppress_clang=27s_=22variable-sized_type_?=
 =?UTF-8?Q?not_at_the_end=22_warning?=
Message-ID: <2bc9545b-e59e-727b-59ac-fecbb4b67f0a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 May 2024 22:23:12 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi John,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/9260539047

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/31d0136a686c
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D856310


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
