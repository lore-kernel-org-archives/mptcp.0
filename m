Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950615CBD
	for <mptcp@lists.linux.dev>; Mon, 10 Oct 2022 22:52:44 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id e129so11349554pgc.9
        for <mptcp@lists.linux.dev>; Mon, 10 Oct 2022 15:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GmR1cIJOZOHZar4pGoGIR7U7OTNdtmQ6COLYtmbG93s=;
        b=ZB1yD6LpsPz4uP1k4TqT25WagoOdjLyA6UtdKeS4OzqeQZ66aaqWAalUxh0ieJGCVs
         g5BoHnDDv60Ur7CxKbasPOO76syfTDbRpBiBCA84L3yJt/ODFycHP1S51pLXqFF42E/A
         90a34z4kEACgszkznZ5T1iuNSB5sRScWnz+ubumFNLpoi7xCii45BXa6YXRvV3rUM1QG
         MzM5B7HNfs9si3Erlkr8Cc0B3CLzW3etbCn5n0aOPVWbzBzZaAYHliTjcSt1Hze31hma
         zahJbhzxZ0HfyTXIchyiVCv7ObaX6NMU1clTKlf/8MP2nv7TPV/0zr5EJAZxOETG9iYb
         633g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GmR1cIJOZOHZar4pGoGIR7U7OTNdtmQ6COLYtmbG93s=;
        b=4k0RjBosMdmeG9AtOsq+Bswlue3T7+fkSYGSIW99SwhnukgJENPC6qMkQwwWo31UCL
         8cC+EzbFMgi7G+y/uvMB8t0z78b1BB6tMnwpRzorx/9xD+ARu5bfAVFy9IO39c1b4BtH
         Eq+6SkfYV7NDtPmMT5O1eqOjMiA3aeWpIfnF0Fw9hgb0w9puudIx2rDR7hWveZV7LZFH
         Vhzt0Nhb7cpIeRykNICu0/oumyzaRSP+1q5unOFESAI52BVgfzcww/Jqa972pLYKE5NR
         JCSwwasFZ1/Ub3SYat/zRs0W4+EhUzTNiN3jA9CRPgEpnqDvRVO1mQaD68w/G9u9Ktpj
         xpJQ==
X-Gm-Message-State: ACrzQf1tXGpglJrcWkaYpHZnBAvAgoQc8PpeDXqmsqsmVr0H5qkNyPtc
	RsC1JfAHAQeEtuBqzhNrsg==
X-Google-Smtp-Source: AMsMyM7s6VqnhvxPg2tR2fXrMDqA41TWAwv7HFvUdPHmZvN//MAZGBeZNieHfu2A+zb6ZoJRmGA8Fw==
X-Received: by 2002:a05:6a00:181c:b0:563:2c6c:2a7a with SMTP id y28-20020a056a00181c00b005632c6c2a7amr10935716pfa.28.1665442363792;
        Mon, 10 Oct 2022 15:52:43 -0700 (PDT)
Received: from [127.0.0.1] ([20.66.95.188])
        by smtp.gmail.com with ESMTPSA id w19-20020a631613000000b004597e92f99dsm6595131pgl.66.2022.10.10.15.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 15:52:43 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Dmytro Shytyi <dmytro@shytyi.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221010221809.1792-6-dmytro@shytyi.net>
References: <20221010221809.1792-6-dmytro@shytyi.net>
Subject: Re: selftests: mptcp: mptfo Initiator/Listener: Build Failure
Message-ID: <a8979393-f702-f8d2-0744-43c56f5faff3@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Oct 2022 22:52:42 +0000
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
org/project/mptcp/patch/20221010221809.1792-6-dmytro@shytyi.net/
  https://github.com/multipath-tcp/mptcp_net-next/actions/runs/3222787780

Status: failure
Initiator: MPTCPimporter
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/444fcb2258d7

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
