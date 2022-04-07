Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8022A17F2
	for <mptcp@lists.linux.dev>; Thu,  7 Apr 2022 02:55:07 +0000 (UTC)
Received: by mail-qv1-f48.google.com with SMTP id hu11so4014148qvb.7
        for <mptcp@lists.linux.dev>; Wed, 06 Apr 2022 19:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=/L7kuzeSaESbzzqHKxqBBZcvGNkEo/VJMm21RjWSZR8=;
        b=PpBU+tMmnBCzGdsAUnyAJTNawm+G9/orRzBKbPTXNSbrQt6O6F0BpdTg1FSRoWNjB3
         6hovLfAwR2/R+QcSlmLe7z4NyXg1Vul4zTk6jIQ9q60brVS0AaWCAcdfQ7qWCSIkx+TH
         s9VHsl8FoEUAWXCYfE9zx14JeCAG0RsVndHGPHDObSSTECRo3YMZlQIRXeNIiLHxMrOi
         wCdvG0CSaO3QYaQpTqqFgax+6cwYP6fzNIoRWqie0V6qPfo4yFbFQ9ViTmOiilWhTkRG
         IFiopR2aaYoEz9XuNyaDSmxDoZoFTDU7gU1Dpn3XY6VQfA+BjcE25WxPvtkoUEn8sphr
         Yf3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=/L7kuzeSaESbzzqHKxqBBZcvGNkEo/VJMm21RjWSZR8=;
        b=UNCQ4NyikvTy59/ewoE0FazH8pmfPkuOn2xI+vzJ5/7hWuRng6k+5zmyWfiuXUzTuv
         p0fRqYF+VDUgmiahx1RS8p8tYDnCeHlW5SfBvLPduWy1hLi5ToYIVai3y5CR243C6FLa
         5wXgjYDe8FrVW5u7e/3Gq0cDCAUUJR4/zUBMNepyMrUlswqVwhRqvrl4zlVnY9A1ihWd
         Tm0bi5Ry07a1l7Wlqglrwz33QcslW8+ouJ4jd2sbmmIWnqmsFxbehkhiIYZRfM2mqa17
         SWMXtBmTp3SLxsqi6WcHKYhrK8P7oyJZocY05KKjgPUEUP0FDyEVuyAM5919bFrZ8nmW
         ABpg==
X-Gm-Message-State: AOAM5314hbU0zMimQbarCYP6XoL/nGVYsreGGXI9HoTelXEhWertffmU
	noXEYb6Mi2/3Ci3pbeaYSQ==
X-Google-Smtp-Source: ABdhPJxEli0PKAuTjnrIcJyUidybeYenla5WYP3w46G6Ofy5HVxnIRQvGIju+uT/BRDuE2B1vMaZFA==
X-Received: by 2002:ad4:53a4:0:b0:430:1d8c:18ea with SMTP id j4-20020ad453a4000000b004301d8c18eamr10140979qvv.115.1649300106428;
        Wed, 06 Apr 2022 19:55:06 -0700 (PDT)
Received: from [127.0.0.1] ([20.110.183.123])
        by smtp.gmail.com with ESMTPSA id g7-20020a376b07000000b006492f19ae76sm10896827qkc.27.2022.04.06.19.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 19:55:06 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220407024241.1757334-15-kishen.maloor@intel.com>
References: <20220407024241.1757334-15-kishen.maloor@intel.com>
Subject: Re: selftests: mptcp: functional tests for the userspace PM type:
 Build Failure
Message-ID: <533300b2-0f21-b0bd-cfeb-8d3913ababbf@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 Apr 2022 02:55:05 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Kishen,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/20220407024241.1757334-15-kishen.maloor@intel.com/
  https://github.com/multipath-tcp/mptcp_net-next/actions/runs/2106318038

Status: failure
Initiator: MPTCPimporter
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/5e7ec49ba116

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
