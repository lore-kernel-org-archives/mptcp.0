Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CC9EAF5
	for <mptcp@lists.linux.dev>; Thu,  1 Feb 2024 02:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706752848; cv=none; b=A7xYJBLB9lb65Pdh09eOgeo4wuxk8iGdLk9pjgczYvTNJUhAldUieCwUs1AD04Dd68ZjZRAJ2lkZsAMG9c8lF5XM48HzA2buY5UWuey5Qbt8v9q+iSLfvo65iEYmgrWKT+TXFPJM0MxNZIMreUAA9BzZOwArZ2VZyAUWh+ZF7Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706752848; c=relaxed/simple;
	bh=+kaXg7MXseit8m4va023LRyvuee+SlakFxrgWzW8VSo=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=eAvEAXLJ/7wnZNw6XTrHP/5WC6O0AEPCxRJoIQIi7/D37Rzj/x5J7Bxo7Hg8lOewl0XZPkCof20T8SX90gqssm23kNwugB9QNuBImIQkWInaX4+iDR5/QRW1NdcNpfMuf/PjLW1E9VXgZW4NbQxqqUQTEq+BlKDrpYVwqcLJQxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqviom8b; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqviom8b"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6818f3cf006so2157636d6.2
        for <mptcp@lists.linux.dev>; Wed, 31 Jan 2024 18:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706752846; x=1707357646; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+j1WO0sO0695dmFR8NtavKbazDC1I3275fupHYACzjc=;
        b=eqviom8bhAPs50ZddNUzbVSr5LV/CGCEevt/JHrFDh8sRv6ojoGA7Js1OS135FPR0J
         RFrQdTXMbQ0hSVsHHjODqRI5GE4E0IGKq/jGVgC1LkfHrlGqEcpi5kZwCzkkmjN0IBix
         RzhEAwCrveC94nwjB7BpHlsZnViG1AjMfRmN0j9mCQkN/XpFEFpth1EDGgIY1V/s1A9Y
         S0g3ikbw01M0hUehjgVoj9Hy3cvtt6BqYGbPhiaIf9d3uHzouV0UnrXnC2pvjVHZfPHB
         rQiIOkUcHmsbQxJPeul8lPbXNNxdneghutQfecAH+9qDtZ+v+UF3uKvDBLRotqw5yN8n
         SrOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706752846; x=1707357646;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+j1WO0sO0695dmFR8NtavKbazDC1I3275fupHYACzjc=;
        b=MouPMYn6UmoKcpNeYjbUVc2rBsd0GU66mU8BMcnXBxD8zmv9MO+lQ7iqMD3ndC63VB
         h6qEDf+0UYBmJPKcUJklne94AS5zxv2IZZOZiuqiR88Kr6039/k85nldP74W7KiT3hKO
         vBdThGdGHDLiRW17KAEQBrrF//xb8W/ip9qN4M5t1FMXS6rXfrUeR+/xOU1xTOANRwR5
         q/tTNh5xJS0mfhlTy73T/sIfAx7EM8EAbdHzD0X3XPPfHSejFLn3FpApEto5raYNeQUr
         pWA4C0RQp94HrI4hylR32jOJrMMUKOE0nowF703CQdn7Ck5nQAYqH9+VHLBej/95sXaT
         WRGA==
X-Gm-Message-State: AOJu0YwktiYWcgbZCaGgG42JFXKBJecp8nGCbtp6Tf8LFoVwi8K4PLrJ
	6h88wUVSJ77Ho5N/d1xOzRhnuzrOXEBBm+4HkOIK1xF/Z2A3dbY=
X-Google-Smtp-Source: AGHT+IFpT8qgHWxRGtVUjSAwAd3k1Dzcvr+XJUEW3nXh6GsLHpc6U29n+1BiICl1mszkrGFuCYC2oA==
X-Received: by 2002:ad4:5c83:0:b0:68c:6eac:ca3 with SMTP id o3-20020ad45c83000000b0068c6eac0ca3mr1360746qvh.9.1706752845838;
        Wed, 31 Jan 2024 18:00:45 -0800 (PST)
Received: from [127.0.0.1] ([20.97.191.242])
        by smtp.gmail.com with ESMTPSA id ol12-20020a0562143d0c00b0068c524a70fbsm131390qvb.66.2024.01.31.18.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 18:00:45 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <eb152068d96e0980d010272f5190da7807f35c13.1706749536.git.geliang@kernel.org>
References:
 <eb152068d96e0980d010272f5190da7807f35c13.1706749536.git.geliang@kernel.org>
Subject: Re: MAINTAINERS: update Geliang's email address: Tests Results
Message-ID: <f60700a1-5fb1-c6f6-9d89-f59b159e4ec3@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Feb 2024 02:00:44 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7734828846

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/2a536c07d503


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
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
