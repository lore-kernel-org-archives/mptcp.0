Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECBE1D9682
	for <mptcp@lists.linux.dev>; Thu, 17 Oct 2024 11:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729164308; cv=none; b=P7ulSXflh/tSePBkXdqMvI/h0AsihvRQ1NKe+yGsrEuiUd0Tr6s6xkEUMy4tjdF28zJBfiz6/Nw7NOoxLrrb5KMGfh7+lavO8WRYKXAis3WHcWWPicJiaMzCJw/ORf0MTa1TjPw/Jw7vWG9iZP81hID/6kBqCmQThLK8CIhshME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729164308; c=relaxed/simple;
	bh=Ox7kxInzWaCrre1qJPmNThfjgQ5xRkPj5UCfb3sutBo=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=nyaQ0Uy9kB+IEbtXboHKQMhmuXbsHMCk+0if+LBiIt63mYDb8mXKsVc+L7e+St99ubkkmr8ibXYO46s6x6pqq0YO1zJJnTFfwjTMiILXAIoAxxUbWlYasudJ3kP2AEODHYiqt2jA9zQS1wCIC3IfrWHAzopaxnfbd9Ww9P2URDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWGlwKT/; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWGlwKT/"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7ea0ff74b15so543566a12.3
        for <mptcp@lists.linux.dev>; Thu, 17 Oct 2024 04:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729164307; x=1729769107; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYblFGGXfccoN4C8zj1j2Ihaks2gKxVUIsuy4eQcFMY=;
        b=TWGlwKT/S8HfHqt4tKzszVfvrHn48q7LnKxqF/6jDdeRJekgtLa0Nocd6oMCOndW3K
         XhqpzDugfurOwmAQ5QuzIGE0xlXYrBFQVNQeUzCsVBUxgjoObQSFhxKIfigWapSdRmeR
         Vy6DHFcWe5puCGWg7cxvPcUpxr5CdxFUyaKFIedxCzEI2394bWVy5QtrcUTmOxc0Ffzy
         mmeZFiLhedE/XdE/3Tv8TRc1C8pNkYEEeJuag9jAG/LEAnDIcGJBSxj+uwqQsvGW3d2A
         /G3CqJB0ek17QUPuqGwk1jnmYUrG6g66Ac9R38bo3+8ddTFy66AMBVvYqMhZ6jdMAd47
         19Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729164307; x=1729769107;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mYblFGGXfccoN4C8zj1j2Ihaks2gKxVUIsuy4eQcFMY=;
        b=qq5pSU8vrRv20eKNS/PwghbHBO/9HU2EkW81nazC7BUmHdMeGhg3JgkA++G4rU01Zf
         v2obGjFMLjlx70cuu/URuCJrSl0g4WQRJ6mVKRd1F0D7XYNaJaypCNdwkTwRc4PgGz5g
         V+WUcELWwEjq8giQEhrj7Tb5np8l+sBJ7X0VIDUYo0Qc9PZ8RT74NFTwJ4IZhArmRlm6
         FXgyQ3z0ZeJFHGU2tuWLWYE+VW1Rxtyqi4G3GBdPl6ZAQXyfL428WQoYqY2bEmwN07G5
         BHQZHJtQyY1wVaYYwOvvM2CUJ5Tw38PBXsCKUOp+5EpkbxfUzVthemcGEqhO6cPkPrRY
         8g5w==
X-Gm-Message-State: AOJu0Yx0blh5EZaB+EJz2xVFAj3rCjYctOaAHitFqkbuU3Et7aTA0ALl
	pwC5DD0jHJ+42TykoertU0pjRo9+zi02F0qzU5Pj2RJtWTLPeTRIi6eA
X-Google-Smtp-Source: AGHT+IFHR5zZBaTsUKYRfYtrKIsuNoCoGV1vUUY30J6pEPviogq8qFSXPiLNYiBNQjnHePXXUjYsVQ==
X-Received: by 2002:a05:6a20:2d27:b0:1d2:bc91:d49 with SMTP id adf61e73a8af0-1d905f63690mr9689831637.31.1729164306773;
        Thu, 17 Oct 2024 04:25:06 -0700 (PDT)
Received: from [127.0.0.1] ([4.227.14.148])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea9c6baafbsm4791996a12.9.2024.10.17.04.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 04:25:06 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1729159086.git.tanggeliang@kylinos.cn>
References: <cover.1729159086.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_0/2=5D_fixes_f?=
 =?UTF-8?Q?or_=22add_mptcp=5Fsubflow_bpf=5Fiter=22_?= =?UTF-8?Q?v10?=
Message-ID: <780fd250-ef00-ce54-b111-87fc06f2a353@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Oct 2024 11:25:05 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Script =
error! =E2=9D=93
- Task: https://github.com/multipath-tcp/mptcp_net-next/ac=
tions/runs/11383143433

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/a092947680a3
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D900181


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
