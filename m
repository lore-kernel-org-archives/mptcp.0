Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD52B80A
	for <mptcp@lists.linux.dev>; Mon, 14 Feb 2022 20:35:47 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id c5-20020a17090a1d0500b001b904a7046dso399159pjd.1
        for <mptcp@lists.linux.dev>; Mon, 14 Feb 2022 12:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=fNUvThrQZBBv4ldJn9pe63OU4k5NgoNmUN+BVgmfs8o=;
        b=KmcsSFzUCJXpFLA+esAe+qcvBe28JjCjdMtkvUJ8aHDmGa/5g2Rkr0WF5gh7rhrC7C
         fb3npeX29Kn4vsE0OXXs15lE6xssZazy7bGLLXirENBAAYS9aqMMPCaz0zYZWIWMEPeL
         UB/VSNmOq6LcE2mzefjrkQ8nR6Dw/1msy8mO/PXxr4R+5zkFCeqEPCTz27nwayeO/o6V
         bKbkMyV9g7lYi/M/id53bwJDDvQi/cAcZVskVuuV2Z6OBWbVPnCrHJxu1avfGPbk0KB0
         uLEZUckStPdhyl+m/Woz67unmEHVoOXaLnIRmRMPl5412OCKy9WVVVETgmsKugH9xkje
         Qkfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=fNUvThrQZBBv4ldJn9pe63OU4k5NgoNmUN+BVgmfs8o=;
        b=BR+MqeOKR2vUsUHLN5UhxscZdeuiJiBypnUiFJ/1EcKC2rBbbpnu4Dp4qvtuxqgcwS
         o2jv8tiM0djdkV6AnDaNJJerNRQMILCfr7IMHR2ypDc0J2gLx126GVMHWlg5LajdTvs+
         FQVMhEkfbC+7N/Whd2xFdvg7LGolWPMlcjXpKlFjv7FbooNFJkvbzyo+XSp6rlIG/4AB
         0e/uDtCb9wpJACC09C7z6gWVQbbK2vTXA+h132JaH5L5Jjxo0LZg7PgeqMHcWRzIsd1Q
         6wVpKPYVYB+kA95OAQBb2y8Uvca7ukoqqudkbogzeN9eUe77SsI24C9c1XRLvhtbS8qm
         Oe8g==
X-Gm-Message-State: AOAM532tTgkp2c2Mg6YtjlsdU9h7Hki07O9botEttAWzdFWFrRlzRWiX
	blvnsGjmWyE9e5Dg3RZY8g==
X-Google-Smtp-Source: ABdhPJxxK9rT2XDWCwauI0g9RIm0QZ4Zw/3D1u85jVFLZeOTnHy6Noqq7K3osekT48bYZqOmM+TNiA==
X-Received: by 2002:a17:902:6948:: with SMTP id k8mr550084plt.136.1644870947378;
        Mon, 14 Feb 2022 12:35:47 -0800 (PST)
Received: from [127.0.0.1] ([51.143.41.103])
        by smtp.gmail.com with ESMTPSA id x12sm385788pgp.25.2022.02.14.12.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 12:35:47 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Cosmin Tanislav <demonsingur@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220214073810.781016-6-cosmin.tanislav@analog.com>
References: <20220214073810.781016-6-cosmin.tanislav@analog.com>
Subject: Re: iio: accel: add ADXL367 driver: Build Failure
Message-ID: <fb02a7ec-0880-45cd-d6fd-5289391dac9d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Feb 2022 20:35:46 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Cosmin,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/20220214073810.781016-6-cosmin.tanislav@analog.com/
  https://github.com/multipath-tcp/mptcp_net-next/actions/runs/1843131885

Status: failure
Initiator: MPTCPimporter
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/8ad435df3a10

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
