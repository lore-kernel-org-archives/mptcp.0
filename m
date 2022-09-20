Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4067E1C14
	for <mptcp@lists.linux.dev>; Tue, 20 Sep 2022 13:17:16 +0000 (UTC)
Received: by mail-oi1-f178.google.com with SMTP id t62so3594989oie.10
        for <mptcp@lists.linux.dev>; Tue, 20 Sep 2022 06:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date;
        bh=3TdtYFb5CmGoGQwSW+yPvsETIc66ixw3YLveEuJZyss=;
        b=jIo5fvHvaS2Sc56XwI/rUigE4u4zVG9BRrabqvaOLANeRhxyJ5Q1dRifWvK8C00Cu9
         E8dzlLZCqU/T1m+DFENnw6iTIS6B+R2dY0HPZ+DYp/MLFwF1r+wAb4I1bpSBkHis83E2
         bL0zZtFmSKZcvE9F2Op3E6tP1Jwj0QaVeBmc5iCazuqjNFMYv0pM2yMfY1XtUsS0vGwX
         kiWfsZ3tKrb4t3hXQ7uXfVGaaVu4rwnIbtf7eJGZKU9d9QD07EhcicxOmhZIc1pLUCro
         jZNFbV+oJIUolF/uO5Onfmym0FHEnOWQiAgPi9IfOIi13Jre6JKe3PtYbp4HVC/RFbnL
         Y2zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date;
        bh=3TdtYFb5CmGoGQwSW+yPvsETIc66ixw3YLveEuJZyss=;
        b=cxugEtvWYTufCsnc+VsgXGE21gJjzOYPr232/y5+rqtLkfHDEzifMedBKeV+D1LX8t
         BJ89nEra32uBuoZ9mJ/cC/XqFtTU6WcrsaonmDGDGnMw/+Jv4NpVTaNypSaNYOwMxfNw
         Ji7QGyQa/0NDoNnWLJ01B+r3L4ZUlfz6J1QhL/weV9FQ05DoF1XAh60EKCMZgdOld6jC
         CDiRgYGxdfk5640mzqBaUiNBCcHJ28OwvJsl/YR3J8AB4xHJjuislDjzwhh/UPC+1xF4
         jx8OTSEvROLBN93HsR4YU+49h9Da3Acj4BgqVKSef7NEYzcbtGulKE8ebXwWMacKmD89
         b1ZQ==
X-Gm-Message-State: ACrzQf2LrcXGvdft2CSB6da8F07CAasxtIFL5b5eeENBn0y2a9748IV9
	8Z1+YAdfCCPZhAFdQyk1Ww==
X-Google-Smtp-Source: AMsMyM7Eq9Mbq0QT4QYO7t9OmcPoI5khBXJcTlHhmbuDSPiIWggJWtaW/hXYOszjsy0AvmWg0l2DGQ==
X-Received: by 2002:a54:410a:0:b0:34f:84d1:b2b3 with SMTP id l10-20020a54410a000000b0034f84d1b2b3mr1561413oic.102.1663679835211;
        Tue, 20 Sep 2022 06:17:15 -0700 (PDT)
Received: from [127.0.0.1] ([20.225.99.11])
        by smtp.gmail.com with ESMTPSA id 125-20020aca0583000000b00350aae903e0sm45837oif.56.2022.09.20.06.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 06:17:14 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Dmytro Shytyi <dmytro@shytyi.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220920125243.2880-8-dmytro@shytyi.net>
References: <20220920125243.2880-8-dmytro@shytyi.net>
Subject: Re: selftests: mptfo initiator/listener: Build Failure
Message-ID: <c6a30614-473d-3718-0229-74fd1278f01f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Sep 2022 13:17:14 +0000
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
org/project/mptcp/patch/20220920125243.2880-8-dmytro@shytyi.net/
  https://github.com/multipath-tcp/mptcp_net-next/actions/runs/3090294936

Status: failure
Initiator: MPTCPimporter
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/413c19c617ef

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
