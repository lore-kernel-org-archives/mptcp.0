Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863DC1993C
	for <mptcp@lists.linux.dev>; Tue, 30 May 2023 13:50:56 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1b021cddb74so22665585ad.0
        for <mptcp@lists.linux.dev>; Tue, 30 May 2023 06:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685454656; x=1688046656;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z2b0pKMwNbKmls4ZxSdIfRq4KJLX4XBunU/m2yQ+y4M=;
        b=FjN3n4rH3BdexHSE+6/L977vuT6PGRbA4VbZxiB5K+vbDyHAlsQUmxkuw+FMvDBqL5
         wWhx7zTKkCrN3cR95Cx8nC/VMpuWDRAv9SU6X9fSNWh2CYtmir7MsqRg8SEnEi++ErSn
         6rYG0xC6qP+i62xorIIBxSTgeVwm8ezXQhuc/OrjrkZotkLDp4PGU6URfYHlszQZ/cm6
         LcFNrk4gu2d8pPcmvUTQqCfN9aajxEJALIaF+LU813RemvxVbUAUF1L1YcHtP9ZcVPaa
         5KkHB0p1EhT3DcvbeQ6tu/qULa9qlwe4cZy936Fwhb2piJTf16Ve495GRm3vg3qlZdH9
         janQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685454656; x=1688046656;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z2b0pKMwNbKmls4ZxSdIfRq4KJLX4XBunU/m2yQ+y4M=;
        b=kw67aUFcTMLnXzTc4ObqC3maDjjjgNzv3YkQPtJc5xoC1kBc0oraZD0TCu0mCckThP
         Vjn58gnaPpRsrRzcZ4Q5DxF1o0q27rHAZCtXXAWuLACYSC+LsEYRKbzcxkTtLgAm08jM
         we5xCPMbr/ZvJOoNDRMuiqO+BTui/ikqnWmjK9YC7VHulxFHxwulPi0A4lok4SCRJJhB
         wHqTq9KtNUM9Yl3+LFxDfWYW9E26ZZzdCClGeKdK6MTVeu+QQzF7bayG/NhwOqO4wgnc
         NdCxJtDmEmfOBZUiamtl+XbGCXyIKb3OpJPT1YttnALMQ+VYLZwOQ159fmJflUHAF5as
         taIg==
X-Gm-Message-State: AC+VfDxLfHNPRR4+SzAZgvbm6wtlL9PvBFebGvhKC7jgvabxSSzfrAcU
	TjukA7e0zgHDJw20b2KYUg==
X-Google-Smtp-Source: ACHHUZ5mM5zfgE5FMGheX5VoEuzmMCU0qQfUY+prhNYxoLCD+c6IGk9LeeyRsZ4bk6bAsfoc7QhcOw==
X-Received: by 2002:a17:902:e993:b0:1ac:a02f:c9a4 with SMTP id f19-20020a170902e99300b001aca02fc9a4mr2711060plb.4.1685454655721;
        Tue, 30 May 2023 06:50:55 -0700 (PDT)
Received: from [127.0.0.1] ([20.171.49.55])
        by smtp.gmail.com with ESMTPSA id f10-20020a170902ce8a00b001a69c1c78e7sm10310959plg.71.2023.05.30.06.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 06:50:55 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <3be9b9fa90210c4543212c088bc7b4ebe4dc8ece.1685452619.git.geliang.tang@suse.com>
References:
 <3be9b9fa90210c4543212c088bc7b4ebe4dc8ece.1685452619.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: Add bpf_burst test: Build Failure
Message-ID: <5d24296a-fd78-94bb-ae0e-80e2570dc4d9@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 May 2023 13:50:54 +0000
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
org/project/mptcp/patch/3be9b9fa90210c4543212c088bc7b4ebe4dc8ece.1685452619=
.git.geliang.tang@suse.com/
  https://github.com/multipath-tcp/mptcp_net-ne=
xt/actions/runs/5122145743

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/ae3dad1762=
e2

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
