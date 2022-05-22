Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7C53203
	for <mptcp@lists.linux.dev>; Sun, 22 May 2022 18:47:13 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id t28so4319280pga.6
        for <mptcp@lists.linux.dev>; Sun, 22 May 2022 11:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=XheQJGPY7jgvIH3zCAWsrBknLAUXtO5033niy6GdjrE=;
        b=CAhwr+6c16jn3Wm27W1PqKH6enCSmQQgUjSSOSM6SLKuE+kXL6N3fq2qGEZlyQzN56
         1WTC7Vkkg2zZE3fushnRmZ5MGIelwLXNtKwiRzZ69zQA1KUc4cvVuyCZaCwO13zERSFu
         Gcxo/aaEFUDmHgzFGoGSk+IV+xv05GCkncb5c3j106yxA+QPo4jEzbFh63+Q4YBzu051
         Bn6EfudPHbtXdkLxijJiSDhFhrJpkeOYICWdTJTSbfn/T4ww3Cetru0LbtdzYZB4uVUe
         Q5zE+Sutzt5LhaoQ8eJPpXdjmlaIxj7SppitXSfhmbdbJOcjPxDt4soUIbWH0L2/+yOT
         M0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=XheQJGPY7jgvIH3zCAWsrBknLAUXtO5033niy6GdjrE=;
        b=WiYqeJk4wiOQT6GsTCx5lRQyIesN6ZBNI2VB+R5+hU3pv7gJXj6bSdkZ3vM36kebrD
         5oXwKAf+1Px2C+gv0ybTNkK8m2P1nVzhwf6flm/2hTiE70sVJKUQGZYJpimorzMHkykN
         KEl/KymMN5Vfxa0fR85QoKemYtKS8N6oz9BqlDNpF7fE8TJdZg/Y014ya/czLE/7mShx
         WHTqwbQz9F+wobs+VWRW5KjEWttXPWZFjDY9+o2NnJ4IrXoku69Ef2V5VFm62s8OMJLY
         g7MvJlrXPkbtxCNYMr8fkb41zoNdiXF4X/Q2QHA9OFMBGovp9+jilyeiCKKbDVcBrdCP
         G5tw==
X-Gm-Message-State: AOAM532h5kTaaQEPpIztkL6cEioy3Lr4c6iAD71Mh4uPyqHrvaLn6gAv
	K+ok+v8jsqVahToFxX+cWg==
X-Google-Smtp-Source: ABdhPJy6W0vJVzvDh64Pq3Q3XAQSoP7Z2kWXeJCWHxKNruHzpSTbkOyqVnDdt6KPxLC+fAW26NJOCw==
X-Received: by 2002:a05:6a00:198f:b0:50d:bf61:3de9 with SMTP id d15-20020a056a00198f00b0050dbf613de9mr20257194pfl.16.1653245232670;
        Sun, 22 May 2022 11:47:12 -0700 (PDT)
Received: from [127.0.0.1] ([20.237.176.196])
        by smtp.gmail.com with ESMTPSA id n5-20020a170903110500b0015e8d4eb2b8sm3418263plh.258.2022.05.22.11.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 11:47:12 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Dmytro SHYTYI <dmytro@shytyi.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220522183921.103526-1-dmytro@shytyi.net>
References: <20220522183921.103526-1-dmytro@shytyi.net>
Subject: Re: mptcp: Fast Open Mechanism: Build Failure
Message-ID: <5819e9d9-372e-4511-3ce0-d317789fee28@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 May 2022 18:47:11 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Dmytro,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/20220522183921.103526-1-dmytro@shytyi.net/
  https://github.com/multipath-tcp/mptcp_net-next/actions/runs/2367376398

Status: failure
Initiator: MPTCPimporter
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/d3cb28a0acf1

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
