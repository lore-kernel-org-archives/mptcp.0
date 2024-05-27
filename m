Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A41C1E4BF
	for <mptcp@lists.linux.dev>; Mon, 27 May 2024 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716828601; cv=none; b=r+bwheUyad5GZceRaRkv/hU2X3qlLDF/uXZbZXjxk1iOSG8X6e9iEd0twccDMUdGZVqb8+VGgQt2no/2+TBpuiGbuderx6uIuXT8Qw6x9oz+KE3RnZ+8f83o/5Tik9eCQX/c0LEnnW3Gh794VECPmAMrq6eIn0yJjo1kl18QooU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716828601; c=relaxed/simple;
	bh=dbIsUOnPfGwt0THNlz1bC/bykGWqU9aPXUDOzi6X0Q0=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=iR+x2IavxYZEekD89ba43Hp0q2BG8aLrnGEq2TiRCefvlemeGH7ECSKHK+zQCV9XZKnsm03rcsLA9/uZAGEsny3Dzpy8VK0CIihi/L7RfteuL94e/NeK7CT1nzYvyM51FH0C4LGEdt+b7r7SfDW7fRBLPlsrz3AwoI8k7tg4IAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XuOMgveK; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuOMgveK"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c9b94951d5so2139b6e.3
        for <mptcp@lists.linux.dev>; Mon, 27 May 2024 09:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716828599; x=1717433399; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9s6wepINxH+qcaYWy/PMVj0fKx4OvUaWwkLLv92v1U=;
        b=XuOMgveKtU9J+/hS4K6bfMNtVvJazbyG4PsB/SIr0DcwYg3pSXDzz89SGxae4EqHtg
         coRtbyWkZyju1cF49lJMpoHpu6DAAjsvhy/dq5BInbO95nIgmZ1Nccnie5eWcKDtl6Oq
         iTpm/1dHHe4SrEvbWqjHDUGpSwq+c2Z6oNy4vmNuioDAJkzRACk8qEb2eTI4LJDPeIKz
         o3pk7GLvfxRYiPmx4SOBV1i4HIWRRjY083Iy6xaf66+c37tkLQUwaFf9oWbzZUYiW8PH
         wFWMONLctiJqGXAddAOKMRSSn45fJOtdakeFz2kYyFXz2uxxnK/MxYC0pdpmmsHvWDEL
         qXpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716828599; x=1717433399;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t9s6wepINxH+qcaYWy/PMVj0fKx4OvUaWwkLLv92v1U=;
        b=SabG1ynF9sN8QUad2WPuuigZOt6JTS0YZ4jENWSDYRBWKy/JDP2LiF6kZMkTJIEdR9
         axxXu/tYiDq73bW3K0nH1chMU8HquFRQpER6J28qUw7vl8wo2jBN8IO67u+4JjufK9MM
         Lznyf01mUzKYRaLIFXa6bv+dYA/eCXe3wF/fwLwfw+YMthMkQ5RzW8vw3+vzL9lpghBM
         q71Y9tStjRAqyWZqrWdnwQh8kq0cyD5Fck2QBXF+l7cj9/D8IC3AGzar1HLdDf+2PWcw
         zSZctpa7o6Wshml4rUKvB7Lb9r1TBNQTA1UHryvJyxzpuj30mAfbY72S88gzejXc/FUc
         37aA==
X-Gm-Message-State: AOJu0YyvH/7vKxEp22OGwigKJ3JYq9DZJ5DdzHprU2Ic5QlD8HOpyZpl
	pxQlQibnVDifmdJUsCMDMnVTdu5ZQ4fcOLhw84PKCo+MDN3ScSE=
X-Google-Smtp-Source: AGHT+IFOxO3Id6pjt0rwr0omDBsBZfOgY/FkReZbzIEiDnq/4CzQjU5gLBa/j2rMToQVyAHhesZTBg==
X-Received: by 2002:a05:6808:2796:b0:3c9:cf09:a849 with SMTP id 5614622812f47-3d1a919003cmr9260804b6e.55.1716828598053;
        Mon, 27 May 2024 09:49:58 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.14.129])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ad850a6dc7sm7751476d6.93.2024.05.27.09.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 09:49:57 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: YonglongLi <liyonglong@chinatelecom.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20240527-mptcp-rmaddr-counter-once-v2-1-3e61360a90ac@kernel.org>
References:
 <20240527-mptcp-rmaddr-counter-once-v2-1-3e61360a90ac@kernel.org>
Subject: Re: [PATCH mptcp-next v2] mptcp: increment RmAddr MIB counter once
 per RM_ADDR
Message-ID: <5d5a8e06-6123-4d42-b615-2a946cdd93e2@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 May 2024 16:49:57 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi YonglongLi,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Unstable: 1 failed test(s): packetdrill_sockopts =F0=9F=94=B4
- KVM Validation: btf (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/925774=
7643

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e39d9b6a7611
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D856237


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
