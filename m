Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F4028EB
	for <mptcp@lists.linux.dev>; Sun,  1 May 2022 14:12:33 +0000 (UTC)
Received: by mail-qk1-f177.google.com with SMTP id y6so7689024qke.10
        for <mptcp@lists.linux.dev>; Sun, 01 May 2022 07:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=Ct6tOdwkQiK3+rT3U82zoKLVLvL4MaXnHSvpaKCiAJU=;
        b=YjspvsPRRGDjkcwOrDDIfze3aPgSvXF2GShp/M9PMvmZeUUD2/a4dGx2S1Pak67Ukv
         2Dbc7VqHQ3XHDOd0nxKMX1jJz1E01M5qO4Fl/t1GB3zQLX87aFOqv1GNJ3jqZOPuladM
         WXZAajCYNPRhYdzQOTom/yE+AofyS6D4inCKSmE+HBND6XPSApbwgBz+kcmDxo3n3nwk
         PAhZup21K11KK4PXax8wNUvSgBoc6GeyGTcYtaPquhe8fTLUjMVBW6UBJ1Ui9LJDfdfJ
         JBuVD1G6fJYGDoOvI5zVZhP7JgxHLLqmDF/uOvgELeg4MYBUVuojgoQOpNLAxPaPlZ7R
         uueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=Ct6tOdwkQiK3+rT3U82zoKLVLvL4MaXnHSvpaKCiAJU=;
        b=MWRLMm+srRz7uhQ27hTQmx34P5YJa4/lVi5ZzQlhBpRLiUyS43jB37jkwVK6LX1ykC
         mQs9gzWFneU1KIA40WZ9Weh0RW66CLp2RhchHhSep9dqCjomS6I/vsMS+D+Au5dhC7w4
         uPqcv7rN0ffQNqwzF0oD1Ps7qrv3MWKmbS2Clw/M006UthKf26RRr7oQHh4r2/sUfibN
         fdtWqxmBuwEJAvQqoItNMKhirAu0oqA8fVblwdT+jbLAQmLiKafixikWiZ7ySkj76FpV
         bDiBQrbnDq+wnhoujdjMh4IfawMgtPkgD/pwN/b5SaIJMxIAhqv920nUjyeZuRI0s5RT
         TRxQ==
X-Gm-Message-State: AOAM531U9I3SZ1icWEOzEK3Vd+uZ1MJ8FtNos9SRsLPBfLeQn4z/oHhq
	20evYteYky/hzy/2+VGQPg==
X-Google-Smtp-Source: ABdhPJwp0leqDw/K9wcJ21jUhYcgYSDuJStdxT6KY0cAUsylX7tRuvldxsJ4nw2VOKIaJ5gWC9sD9A==
X-Received: by 2002:a37:9cd8:0:b0:69f:b618:c7ab with SMTP id f207-20020a379cd8000000b0069fb618c7abmr5787889qke.722.1651414352769;
        Sun, 01 May 2022 07:12:32 -0700 (PDT)
Received: from [127.0.0.1] ([20.114.130.252])
        by smtp.gmail.com with ESMTPSA id d188-20020a379bc5000000b0069fc347ef5dsm2590169qke.74.2022.05.01.07.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 07:12:32 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <2c5bd5067e0d508dc5e677da3848d6aa6f610174.1651412613.git.geliang.tang@suse.com>
References:
 <2c5bd5067e0d508dc5e677da3848d6aa6f610174.1651412613.git.geliang.tang@suse.com>
Subject: Re: selftests: bpf: add bpf_first test: Build Failure
Message-ID: <742e3e57-109b-88cc-81ff-de65b92f8974@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 May 2022 14:12:32 +0000
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
org/project/mptcp/patch/2c5bd5067e0d508dc5e677da3848d6aa6f610174.1651412613=
.git.geliang.tang@suse.com/
  https://github.com/multipath-tcp/mptcp_net-ne=
xt/actions/runs/2253717943

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/cfcd857eaf=
69

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
