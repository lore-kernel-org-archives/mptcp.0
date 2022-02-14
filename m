Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4584C8A
	for <mptcp@lists.linux.dev>; Mon, 14 Feb 2022 20:58:59 +0000 (UTC)
Received: by mail-il1-f176.google.com with SMTP id p11so13333940ils.1
        for <mptcp@lists.linux.dev>; Mon, 14 Feb 2022 12:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=schJSkcWuQQmzM8fSgMYz5TSWCDlAaJD7tHmdzEXTsA=;
        b=YJHslhJfbexyMcmbmJO2bvolWZQgXmM/g+eue4cyjtC+ClpyG/5BuibT1+QAfZEqUL
         Qj87x+GIiYuaQzEK18M+QRQvWVEogWQDZM0zu01OGQELa+XEr9A3iwy3SqTXxbUDEv8O
         7GRe7m2DfUiPYJnlWFr6tiRTS8ovWfMoNUXXg7FP7okuOt93J8fL8f2Az5NHr8fVE5Vi
         oPqKZD7X9uUWCY3yclt93lqtcFr8MYsCweGK/izb94Tzt2fA75s7qZvZiMC3cpDC2g41
         5GVDiwLt6Y5dEHcUgBXBIb41Jg6IL65dIblsZQDvEIPTgkmIek92vRY3hAxCGtAOjq4n
         CzsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=schJSkcWuQQmzM8fSgMYz5TSWCDlAaJD7tHmdzEXTsA=;
        b=Bxat3JFqSxM/zUKun5RnxBREGgcV66lrli+pEbPvVF0scIrxks0gbhvvfb3dtZfjsf
         MYwQ+zpm2fP4HGkgNxU6C8FnymWdu0aLOcqLsnxNVVF9+M6DL7pWYV+5KwQfGzltXTbV
         JEznB9PnFIHtMfA5X+LCrg8RLefNa3OiEI05druyV36rVskNTkdIFVGYAidwhFMAtQWz
         GHoVAl19k+JaM/CV3mvdHGJnCmCAjClV38+Tdfmc5emQlIIVBtLhwKbHso8sxrLY5Ix+
         2DyaAXZrQRl0YHlvVqAUi3eK7Yi6bcQEPmzVpR07fyuVEEMCNCBi6z7GmrN7DZ4/RSWU
         FE9A==
X-Gm-Message-State: AOAM531dShZj1Iq0bj+vKYFUoq/JuTv6alNRRvVdlWxpZqrRoasKg3ui
	Y4t6UcUcyg0ibPIq3n/lS8JrckAoSwlZ
X-Google-Smtp-Source: ABdhPJzdA8N13uBUIuDqg4R68QoeAwuj4s4P4A7nNHSA+3v36sgGIyEhfTeSBPMIB3wbKqI0wdBKwA==
X-Received: by 2002:a05:6e02:20ee:: with SMTP id q14mr458389ilv.38.1644872338826;
        Mon, 14 Feb 2022 12:58:58 -0800 (PST)
Received: from [127.0.0.1] ([40.122.187.157])
        by smtp.gmail.com with ESMTPSA id p11sm23236622iov.38.2022.02.14.12.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 12:58:58 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Nemanja Rakovic <nemanja.rakovic@syrmia.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220211162142.2402-1-nemanja.rakovic@syrmia.com>
References: <20220211162142.2402-1-nemanja.rakovic@syrmia.com>
Subject: Re: mips: Enable KCSAN: Build Failure
Message-ID: <1e9f47b3-3025-a126-996a-c23086225641@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Feb 2022 20:58:58 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Nemanja,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/20220211162142.2402-1-nemanja.rakovic@syrmia.com/
  https://github.com/multipath-tcp/mptcp_net-next/actions/runs/1843234131

Status: cancelled
Initiator: MPTCPimporter
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/6b8a96a1f02e

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
