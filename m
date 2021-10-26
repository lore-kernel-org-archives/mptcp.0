Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489362CA4
	for <mptcp@lists.linux.dev>; Tue, 26 Oct 2021 05:08:02 +0000 (UTC)
Received: by mail-ot1-f54.google.com with SMTP id v2-20020a05683018c200b0054e3acddd91so15598508ote.8
        for <mptcp@lists.linux.dev>; Mon, 25 Oct 2021 22:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=VanDQHgxGTPgh/sl1pu71epgXdx+QgkUeKy1isgRHoQ=;
        b=jyxDxz1uR505kkQPcLfKRQe2mMNJfJcKfvYodYZ65WOEomTClYzegH2KZjxfvfwUQW
         /w0MFibZ1+fUXbWvCOVIV8Qx07sFnoX8VVwEvlWZHpjhgzJ2VKa7rReN+l6zyBQOdMFG
         ZtQ099/E2u0M3RirsxjaVqvN+ayI8ol2Rsc0yBXsWadz+1f50WiaG4HVm4Q2IhdLmMut
         tG/ndvqUW5rtg3tbojz5OFYncdfaqb0bqZUgV9ZK8FkxX2onrjIcCMn3nqYMwpgKf2c4
         p/2BW/HXvQ+/T4fd4iUzJlCKBOmk1QqVZoBpKMzZXDYeQ92mk/SiZQ+z8qb7Tx+SdzIL
         AztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=VanDQHgxGTPgh/sl1pu71epgXdx+QgkUeKy1isgRHoQ=;
        b=R7xz7GmxmPT1Z580oglmExvQSPtJ7UxfKRC57I5IMAaZ75bh/0Ovkyv2N7Lzi/zSoJ
         c+8Il1Y613d4MToG9XcePUtFh+1QQnvI2dsbHy7MRO9fV5T2/pwKbOkaD1n68zOVxhWi
         ZhkADK42faG9+iyj6W4OflCWqO6I0BLE47vk54JrCz/pvox76iDHpdJZwYZT38Dl52zD
         d1xGoR707C7fx5DvDWJBbJ6aildHIoYFbYr3PRTudToXkyn9N+NEy+fB1iYDnCFZDvBF
         cMHmJtzuyRJKPsvOubMuOhEHIy+7HeLSVLuTLB5H4tlBm+dhD3jstGRu68QnrySubRBl
         gYpw==
X-Gm-Message-State: AOAM531vgcxHSJrPmzZypUN52uohmUAEWl5i9VPU6M2g9DfnE2oTBk2v
	tWYCWZWWdevwexZZVJ/4hw==
X-Google-Smtp-Source: ABdhPJzo1cfO7fQT5rKNmVq4w/xLikCWWNPNc2+kBMJzHCpm6r9L9GakVNheaIElHuRNa5PVFGIc0w==
X-Received: by 2002:a9d:5f85:: with SMTP id g5mr17236304oti.139.1635224881510;
        Mon, 25 Oct 2021 22:08:01 -0700 (PDT)
Received: from [127.0.0.1] ([20.97.116.9])
        by smtp.gmail.com with ESMTPSA id f14sm4150029otq.10.2021.10.25.22.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 22:08:01 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Davide Caratti <dcaratti@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <1207c7d44dd4d1a630afc8b7018cf4185fe4a489.1634827708.git.dcaratti@redhat.com>
References:
 <1207c7d44dd4d1a630afc8b7018cf4185fe4a489.1634827708.git.dcaratti@redhat.com>
Subject: Re: mptcp: fix corrupt receiver key in MPC + data + checksum:
 Build Failure
Message-ID: <d451b4e9-b44c-e496-4401-ce769a91db0f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 Oct 2021 05:08:00 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Davide,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://github.com/multipath-tcp/mptcp_=
net-next/actions/runs/1384159937

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/8d20a4498b=
fc

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
