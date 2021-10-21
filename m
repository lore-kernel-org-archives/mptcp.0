Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CB868
	for <mptcp@lists.linux.dev>; Thu, 21 Oct 2021 15:00:52 +0000 (UTC)
Received: by mail-qk1-f175.google.com with SMTP id h65so1925332qke.0
        for <mptcp@lists.linux.dev>; Thu, 21 Oct 2021 08:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=f0uVB586ISMyKWjFmNtJ2tHTpd8S7PUFUvVVlQC5CPs=;
        b=YoKaATOZeC9DvKVkClLLdqTUZ7+NaotNWo7YSv26wunQYwJHU+oTCZNwImu2QKR7TQ
         7pTiCxi8Q1iRl9FvrvaW84ftgdNNmvbCuhjN9FO08etTxCaOxPlaeYwmfsh+vHgUzI+i
         grhPEXPxz5guI6MhTGqdAu3GeGni5yA/V9UBCdElUgrPGAw6twYOh/tLz0Zjg2TuatZ4
         cZz6Rc6gDvLefRLl8Gqy8OvI0JiYGl4jfPiYaPEfayvNGGmOqGm+uEbbGGDbznsH9YN4
         pTBJfu4+qRfUE1G0ZurLCjL25dgm/QBZgkZE5AxJQB2Nn6pQ7NwBIZuXAZtKbnfp2+qY
         0OdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=f0uVB586ISMyKWjFmNtJ2tHTpd8S7PUFUvVVlQC5CPs=;
        b=5l/wIqGEy0F7ZWiDDAO/z5W4kPDP1OkwPDAxvfaE22civq4w/+1hzVru3j+M/mf9SE
         In3M0tKDnbXg7YU43Z5p8H8OuXd6cr2caAYU7BITBb4j8eTtH8yH/dmOE6LgWuc+nV0/
         +Miutp5sjdDtAB9OLQVOxF6ZMkj/w6EvutS1apL27eyj8IU32WCggf31VcQ8saDSiaeu
         nqMlVUyDEkA0jPun3Sp43hlWfvpt0KAm8LLxCyg/AanwwbNGHmobToYxGaC4LdoXPemt
         sWYYPngwpbVHhgXHZNC6oKzFSv271uXLsHvQXiCW4vX0oANnWHwkyGCe2QO2r0Z5bZ4m
         84tA==
X-Gm-Message-State: AOAM532ojyiWH+acDKWSHXhpxhZHeM3g5hUwxXldY8S5V0riW67nlXoW
	mYeMapnEkL8mkjsTUMFnWQ==
X-Google-Smtp-Source: ABdhPJyZRHTCVasDfLqNmLUSX7x+qvZSTokhRZHomYP8+SganazgDsQjgajIswFhrSDWDXWwGmoSLQ==
X-Received: by 2002:a05:620a:1a28:: with SMTP id bk40mr4932779qkb.224.1634828451405;
        Thu, 21 Oct 2021 08:00:51 -0700 (PDT)
Received: from [127.0.0.1] ([52.242.79.64])
        by smtp.gmail.com with ESMTPSA id i85sm2639527qke.61.2021.10.21.08.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 08:00:51 -0700 (PDT)
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
Message-ID: <b8880b7b-7d66-d6a8-633d-1fddfe87beb2@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 Oct 2021 15:00:50 +0000
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
net-next/actions/runs/1368461915

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/3ab9a5a327=
1a

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
