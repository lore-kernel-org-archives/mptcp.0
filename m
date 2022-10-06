Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822B9812
	for <mptcp@lists.linux.dev>; Thu,  6 Oct 2022 12:51:39 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id x1so1630177plv.5
        for <mptcp@lists.linux.dev>; Thu, 06 Oct 2022 05:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date;
        bh=iLChXU1gtqYhvEzZEys9N9GOMaPox1y+bsFupVEl7Fo=;
        b=bLjYDDVYXBrG49F6NnfyMwWT7EhA57yL3CpqBGnifNP/BMhK2zO6d8RVeqxSw77wNy
         JGYq7dR6qD5I4bHnVDAo8qvgMnNTchv1PwkeAJvBFnxoXKu97MsSS2276YaxSPEB+xXl
         Oy5kCr4JUVKw0XxxoT0H5Wo4L5JKbCTqFEWQthDZr/mkpK7J6XxuTDoejBcxxe5hLBQu
         /5FXo6In4mXpComxFMpW8H39Ik0I7Fvbtijrcr7CCfTZcr+hrURlqeDOFKRgFRLfQJiC
         YWaq7eaXLy7oPvHusHGEjlluubYtO1WV33na0tQ8p4ZZWHVzOlVGXyRSakLjVDdAt5sK
         NYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date;
        bh=iLChXU1gtqYhvEzZEys9N9GOMaPox1y+bsFupVEl7Fo=;
        b=Qc+GmrlZlGyFzeVmdOcWyn9TqlR8lR9wHf+Lm0Tvh4JwS2qg2bs2hJmZBljzgxEGJ3
         pKNDG5tgrm3CQFL0ZZxEy9kFbQnEkbfarx8CJMEMuEqnQGARfi4lucTx5D4yeei8elUu
         mDzMAaSRdKmPelFGkSOmgIqKRizQvQKNOuoNBf2jV52aisx7YUwdzRWs2sPyWhxuzNTf
         35NlgFiV2y6W2JB5Wzxy7wr+7ehnz1Xkxf+dnGdJb+71TGCuz9e2ObgjdOL0+hZ2qPgd
         ll4dysGuQpgD2nb6gGILgI3TwcPMQLSHLHun2M8JP39PKw748gCiWzz2fh0B9q7wRWXg
         e84Q==
X-Gm-Message-State: ACrzQf0KQ1secLAMCaVxIhyvoPM/eBp/f+exSnAm5JgZTpPJJEkpfmK0
	uU8FDGF2ksxQx8QIxqNsDQ==
X-Google-Smtp-Source: AMsMyM5GDyjpLxrbbdr2Iax4hv8qiRZZsnGpeTyaE7kHW6jMwOudbOYhZEqxPLgHYlicQZ0mVZWuEQ==
X-Received: by 2002:a17:903:186:b0:178:2ca7:fae5 with SMTP id z6-20020a170903018600b001782ca7fae5mr4428891plg.173.1665060698925;
        Thu, 06 Oct 2022 05:51:38 -0700 (PDT)
Received: from [127.0.0.1] ([20.66.22.235])
        by smtp.gmail.com with ESMTPSA id pc14-20020a17090b3b8e00b0020a28156e11sm1393723pjb.26.2022.10.06.05.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 05:51:38 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Dmytro Shytyi <dmytro@shytyi.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221001031502.29152-8-dmytro@shytyi.net>
References: <20221001031502.29152-8-dmytro@shytyi.net>
Subject: Re: selftests: mptfo initiator/listener: Build Failure
Message-ID: <3436b3c1-c5dc-18bc-8e75-786fa8d1b3df@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Oct 2022 12:51:37 +0000
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
org/project/mptcp/patch/20221001031502.29152-8-dmytro@shytyi.net/
  https://github.com/multipath-tcp/mptcp_net-next/actions/runs/3197013753

Status: failure
Initiator: MPTCPimporter
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/7c22bca6e0ab

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
