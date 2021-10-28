Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C9A2C81
	for <mptcp@lists.linux.dev>; Thu, 28 Oct 2021 12:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1635424076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TXjnXnIX2HqJz1oiqNkgeMbx83wmhNLvyIcMb8Tc5qY=;
	b=QjgGO90/SC7cMtAQdTiByfUfuM2E+6o0RRH0rmUmUDIlg+CbpcXAeHMU7HbEO6Sqv2+p/J
	C+UgBW4lSczACZEoYf+hTLO6KCECJSsmurOvBq3A5Xr2Ufn/W24/F1y+uxhsytRI1FKD5+
	/1QSkWE0YbaHZLdRQgGq0Xtab6aIQ5Q=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-K1-DIS_0NcGyhd-Z3_aX1Q-1; Thu, 28 Oct 2021 08:27:53 -0400
X-MC-Unique: K1-DIS_0NcGyhd-Z3_aX1Q-1
Received: by mail-yb1-f199.google.com with SMTP id f92-20020a25a465000000b005bea37bc0baso8525076ybi.5
        for <mptcp@lists.linux.dev>; Thu, 28 Oct 2021 05:27:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TXjnXnIX2HqJz1oiqNkgeMbx83wmhNLvyIcMb8Tc5qY=;
        b=nfLo4GTbs/dMZTTlog3pHQ/Np2Fn+r1SRhyrX4L3kL+TKf7/wkVLc+WMMf+asZoUMj
         oj1aGDVl/V4WyHRRlQSdTxZa6ZZ7Nxpde3knz8PpcsdAmTc6ZL2NxAB8ppzCo1ebCIei
         zriM3jyFe+IYBB0kxBZKuH15bU4Z0irfZgRTusJpoDcRHB2bOee5DYmMOrCSFGmPCpyY
         WgyRXObqueZ0U1DqurmQhrHXqbz7hDPkvw6lmR2oRYuCSigaEhVbeL3dy+M+ZTvSc+fh
         VLYAEdytu3XQSg0b1YyJGMI4tRhnAPxqvxNCw8usUL9Ey9ffKOnqXI1uh1meOUfz5G6C
         hoOg==
X-Gm-Message-State: AOAM53262EvlKOMT3Qei0tnNU791lX9RQazlsjfZDwYHvgEgVRH+vBC5
	psaXPRLVSOUmVqVvX/f/+Gx8go55wFPhAaVDeCOtfNrpMwHfmN/IYDJiLLl6GYckkAvlCMe0fXF
	CtGyTkEIGMYoRl4cj5Qt6yydMjjkys+w=
X-Received: by 2002:a25:ae0f:: with SMTP id a15mr658700ybj.157.1635424072903;
        Thu, 28 Oct 2021 05:27:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9uJ9kbQ7dD2aHlgqrKbdLFk4V4YbHCecFEuqGcNKS4/trwlPnX3klfbg5hroWUk2JWwboLZqZavM51rr/8wg=
X-Received: by 2002:a25:ae0f:: with SMTP id a15mr658680ybj.157.1635424072698;
 Thu, 28 Oct 2021 05:27:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <bfa01f99cbb0479029ad284b020dbb250d19b941.1635390811.git.geliang.tang@suse.com>
 <20211028092338.GA6915@dhcp-10-157-36-190> <CAKa-r6srprPPPhUCXW3YnsQEL0ewFBptQFvUo_9mwtw_mD7DOQ@mail.gmail.com>
 <de15a4e9-0140-2b18-7a5a-c010980eedc2@tessares.net> <CAKa-r6t_ajhpvO2PnGyL2E-0FuV+r9D1i31vO9J71M8XiajnkQ@mail.gmail.com>
In-Reply-To: <CAKa-r6t_ajhpvO2PnGyL2E-0FuV+r9D1i31vO9J71M8XiajnkQ@mail.gmail.com>
From: Davide Caratti <dcaratti@redhat.com>
Date: Thu, 28 Oct 2021 14:27:42 +0200
Message-ID: <CAKa-r6tCF2Y29eMR3QG+jA+VX1PH=CvH0xEKtkrDU-CPowFLtw@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v2] selftests: mptcp: add mp_fail testcases
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Geliang Tang <geliang.tang@suse.com>, MPTCP Upstream <mptcp@lists.linux.dev>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dcaratti@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Thu, Oct 28, 2021 at 2:24 PM Davide Caratti <dcaratti@redhat.com> wrote:
>

> also, please consider using jq rather than awk. Specially if you are
> planning to use more than one counter. For reference, see [1]

ok, but where's [1]  ;) ? it's below:

[1] https://elixir.bootlin.com/linux/latest/source/tools/testing/selftests/net/forwarding/lib.sh#L701

