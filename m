Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268087B
	for <mptcp@lists.linux.dev>; Wed, 29 Jun 2022 22:42:11 +0000 (UTC)
Received: by mail-io1-f51.google.com with SMTP id y18so17479241iof.2
        for <mptcp@lists.linux.dev>; Wed, 29 Jun 2022 15:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=wdI16GoybfH5nE6sSSLOoss2GfeRjCWyl5YA/NT27Jo=;
        b=jSkOVn9Q1zu8it1vGfzh9Yv+Q24LbnYvT1TIlEidkC9UiG8NQ9Y7W/lz5m2Maoe9kB
         Su1YkIjNHuXFOY65ETvpwqboIxC04dtluiSHHi0vzfrOAoC6vmc/5omPzi9RRmS5PAQ4
         IgfiXKHJAY7dTyZZm+mgsPb303sFNCRvVVda4Hveyg39L9Bhhok+rqxRt49mlVLf4ZXJ
         bAQd/vP9BL52T92h2EKnCmxspHsxlOH3tpnrJAFtsFcjxlxv+Mpbd6wyFa78h1/jfgJY
         t9dKvqediVnqU5Hwvtbaqv+AtlF24IC09V26A1FmrKmQHN4WD75ZoMBqv8OfzzNwWNWf
         T9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=wdI16GoybfH5nE6sSSLOoss2GfeRjCWyl5YA/NT27Jo=;
        b=h8jU7yesuHYun9ANAkxrlfoXzJzeuIT3sfBiUAKtpzjmR9Bf2jPZ9Sz864z0Z6Bplp
         ghSzCTk2oH1lBc8IRa9eoXUqQ/wlCZjJ2wjqmSDJsbzgaRTNamDJ0G3PBDDvLwYTfu3C
         0KQka3p2Rgy+bsGtiU4tVd6Qv0vEVF3ZFYdxljkgy+vtr4NEDAMrTei6suzK5+U1ICVu
         FwNKJkBXzHdc5LORoO6EZE02BqGz7UBkWtAlHb1qlcZyqLypzf7Z4t9kq/NuYmcZ+vcq
         3v2+SCyBLnyuwWVmvi7msBrxIN7Hu2b4QWznnOmmmXyLELMSpXaR/CIUdeMLRTi1C2Wa
         TAXA==
X-Gm-Message-State: AJIora8ujf3HHnnzlC0JNUO5qEMuvXfzAd8vSrvCDrZywbYIdfRESFMP
	x2WIvwiltuOxstjZr3YiDJCy7npr5TcC
X-Google-Smtp-Source: AGRyM1smrdGU+PNFf7dXtRY8xAw09Vk7nM1PgM2J1aYCUs2zJ1AElhTvStYZ37Zl1mvcyHZPQlcM3g==
X-Received: by 2002:a05:6638:10c:b0:339:e949:b332 with SMTP id x12-20020a056638010c00b00339e949b332mr3358804jao.22.1656542528761;
        Wed, 29 Jun 2022 15:42:08 -0700 (PDT)
Received: from [127.0.0.1] ([52.165.187.63])
        by smtp.gmail.com with ESMTPSA id q9-20020a92d409000000b002d90ae7b6a3sm7471036ilm.12.2022.06.29.15.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 15:42:08 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220629223550.655928-3-mathew.j.martineau@linux.intel.com>
References: <20220629223550.655928-3-mathew.j.martineau@linux.intel.com>
Subject: Re: mptcp: Acquire the subflow socket lock before modifying
 MP_PRIO flags: Build Failure
Message-ID: <fe2f0ff3-db35-fc11-71c5-bfafca5d4e0c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jun 2022 22:42:07 +0000
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
org/project/mptcp/patch/20220629223550.655928-3-mathew.j.martineau@linux.=
intel.com/
  https://github.com/multipath-tcp/mptcp_net-next/actions/runs/2=
586322258

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/2c27d7a3c2=
8d

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
