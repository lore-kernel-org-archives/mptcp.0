Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FADF68
	for <mptcp@lists.linux.dev>; Thu, 18 Nov 2021 14:24:46 +0000 (UTC)
Received: by mail-oi1-f179.google.com with SMTP id be32so14530105oib.11
        for <mptcp@lists.linux.dev>; Thu, 18 Nov 2021 06:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=+qB3WTTQ7V7t/ubsonAurwEBzdcnwoGqqp6kCxHyge0=;
        b=DylsOXFp6d+/iBOWqZR4urYNWGgQgickI+q2GokX6MqkQJxxSH2fDKOizOYPc7piF7
         EbQHElG2ahtT6EuFcGyMYlQAlQTwq2leIMAJL0hkW4C/zKliTV2epphEGY273nRM8c1V
         /yjLKnk3CIhEkIqR3wSTYIKlBYVArjMg72limfjbzUSpuxz3F2rA01YSTD8YnBJ+3OFm
         NcWxXWwkrZWglWT7OUBn0lDaHCSqbWsppqHhRK1793GdYLo6ASZUjM8D9HgT4KJ2/nG5
         2fwx6q4ZEw+xvoDinWVWXEDuPXXKf/fmS7oqZwvFX7MFK/hhVrL702IJazAFizyweXbY
         fViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=+qB3WTTQ7V7t/ubsonAurwEBzdcnwoGqqp6kCxHyge0=;
        b=vSZZ0iFFaVI9XIelusvHhHIJSYN72EPzBNyTn8AzfiUM/4lrQNgORzV6oJurIvToke
         6XYM0PsVr36zvit1d9FUuoXCf/eUTvtc1unDV3fB++A9Vt0Bf3jwBEkhy1f5WWLxYNjg
         b8KDduZt+K0yHT34Va63XL2BT/TkVyBFb3wGyeIgmUH74UFfRIcsI4xEhl2NQN0OX49I
         oefi2axXO+wWeDeNxvpt2ilu3laYW77qfj60YNE6ISZe4w4IX4Y+j7GxyAoKY1Cdnhz0
         0svDJ3wwpJ2CVJpihIZxN27VfrJ7WtA3qON3hSc5Qi35gFujqdhghCavl1lu47Gxe877
         kDYA==
X-Gm-Message-State: AOAM531i2b1qXV+vPLGryxHFIJTSxzWYGarf7eGkHCBZ/BizjRwtp99P
	viy4x9zP/eFT2O+j2aYnl3se5/UKPw==
X-Google-Smtp-Source: ABdhPJyhj5LyaTtzp+piM6MCy6FQXZ5YX1o9eqzDMZk81B8GBrpKJVmyX6F2xnTjnuiJ4VYRdTHfHw==
X-Received: by 2002:a05:6808:1485:: with SMTP id e5mr8394331oiw.156.1637245485610;
        Thu, 18 Nov 2021 06:24:45 -0800 (PST)
Received: from [127.0.0.1] ([13.65.136.219])
        by smtp.gmail.com with ESMTPSA id n20sm562389ooe.7.2021.11.18.06.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 06:24:45 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20211118013005.263660-7-mathew.j.martineau@linux.intel.com>
References: <20211118013005.263660-7-mathew.j.martineau@linux.intel.com>
Subject: Re: selftests: mptcp: Add tests for userspace PM type: Build
 Failure
Message-ID: <dcb8fd55-8373-e842-29c5-d1a90b9904c8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Nov 2021 14:24:44 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Mat,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/20211118013005.263660-7-mathew.j.martineau@linux.=
intel.com/
  https://github.com/multipath-tcp/mptcp_net-next/actions/runs/1=
476796774

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/7a651678e6=
19

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
