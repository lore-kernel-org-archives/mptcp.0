Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038DD2C81
	for <mptcp@lists.linux.dev>; Thu, 21 Oct 2021 13:50:34 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id i1so424246plr.13
        for <mptcp@lists.linux.dev>; Thu, 21 Oct 2021 06:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=iux5ceKCBo+50yn5QrMX9loHorHCxlFfqb+bT3rUsGs=;
        b=LywZMwf7/1qD4CAPoHmSuaMNdDf7JRSW6N4U2sfS+dkMBFMEMKzuC1SGLIQtxcNCeN
         T86Xqb8JI8lhheAOJZu2nvCzfS9LTVgjye2vLy8yEWgIj9P7UnRG+ZTPftYw2HXVoGwv
         f3IvK61yrKIOtlwv38xC2k4JFegSWHtZRoEc6YDCtL64qfvVO5PdyLBWN7qMnWsZWLhE
         o4phf6/Rf2Wc8gXmPJdtPzZ3ZropP6oVhB7HnuNVQ6G0whbaX5PXhXzSRfmcWR9MRHzg
         sxdAbnDNWXbnr7LZ3o5qwTdz7r86XjSUnRDQHtSeeA/Vt7D1Edo3jFHPpjH+RbnxRdkS
         bEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=iux5ceKCBo+50yn5QrMX9loHorHCxlFfqb+bT3rUsGs=;
        b=z1wrcmNqY5/ysQT91Uvi4qXhYVneQgw5TBMfC2cJ2XLA18FKzri+8LhXg13k7dAqHL
         Rhf6ALE6VMUjg+foqhnzWNudPb/yWl7tkq5PS6d/HqXD9r0RwBrA39XJZpWKA68G5q8k
         twRKfJ7tgJEPmEj6KbMMPi39Ea8RobLcNcqkgO2h7IiReDmqzUjk0d7MVHoLwGX3jU/I
         mIEKLu4F8c6TSWxVmRD0WI8aIxB9Z2pvMZtsLy01nzZ/UHK9A9ZtlbXDgotxyHD6AFW7
         gOkT3EEnvVto+ns/1C3xc71lJdf/aQ5C5Pb8c6yXs4Cz/5lEb1OwcDlbA283yA9E/odF
         xIKg==
X-Gm-Message-State: AOAM5331dDYmrMMUkknBpU7rjb1oZK6utT/i+CC4W406+NvIlXavaTUO
	Ryz5WOezGUq3gEXg4LRGFw==
X-Google-Smtp-Source: ABdhPJxlFTOj7W8rbIKP/+Tqlv4gaEQD38olM+kmM3ezkPBD8FFgmq1HcHVrZ1agkLdBcMOiuC+ipA==
X-Received: by 2002:a17:90b:1e4b:: with SMTP id pi11mr6816141pjb.179.1634824234486;
        Thu, 21 Oct 2021 06:50:34 -0700 (PDT)
Received: from [127.0.0.1] ([20.115.143.175])
        by smtp.gmail.com with ESMTPSA id kb10sm11128728pjb.18.2021.10.21.06.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 06:50:34 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <ernel test robot <lkp@intel.com>
References: <erneltestrobot<lkp@intel.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22mptcp=3A_infinite_map?=
 =?UTF-8?Q?ping_receiving=22=3A_Build_Failure?=
Message-ID: <2f36e78b-aba5-df76-b579-86ab01267d1f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 Oct 2021 13:50:33 +0000
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
net-next/actions/runs/1368186309

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/c072904f5e=
43

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
