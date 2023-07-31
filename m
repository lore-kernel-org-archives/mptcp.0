Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83F717AAB
	for <mptcp@lists.linux.dev>; Mon, 31 Jul 2023 11:24:39 +0000 (UTC)
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-790aeee9928so15605639f.2
        for <mptcp@lists.linux.dev>; Mon, 31 Jul 2023 04:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690802679; x=1691407479;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EhnaZz9KHaLQEn0VndV6RkbnzZZ95NaxrMixwOBmaFU=;
        b=nEADmmMgbKyGIZa7IuTeeyc64e3hZHb2E5R8keTnbijxksxDjRXxE4i8O78vQzksaj
         K4SUM+3Bb5wHepCaaviV9O5hurPJbWGH2FbqD9xTG9aEs2DDK0PFlQWToI6yndmFeqSC
         qp+mnEgW+QOoVFTqG4n4PVb+eEj2AXg2XMIR0BqW6ecZ2Fy+DD3E58vWpQwLXD+kBwjq
         xqfclAWE1Hb5R6kH9MpdwmuwzsFB4INF3DssGACCs85gXcSNd+QOJoLFV5Ne3KXXuD6g
         Pa9q4Gm5gdHCt2Lp+lx+qaavcseJ3PtvJoM7UJciUK2NmTOsmL32LuEux0F6WY/R3zst
         NnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690802679; x=1691407479;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EhnaZz9KHaLQEn0VndV6RkbnzZZ95NaxrMixwOBmaFU=;
        b=dh5hS5/8Ddx56qoDu/ak+PceVmLyAtqUtPSI9x+6MzEciyTuZ7sZpjO8BynX4dX9oa
         FaAMxBwqp6BK+t1SwoB1iNvqLtFrbkOnijeJ9ii9tkc8//j4RVWIhnzaDLM0Cdds9PoQ
         c3o6Oqk+zR1nHyXY5xeJplXiD+VwiqREvwr9wOs/Ixfe3SPlShLXGiyc5lCC92SywP3F
         XAvEoXjin8JHcup4evnOk2NCMi7NvCVUYsP+PpxKSqh1cGvdeaiKfSGr6JmYcFOocAac
         ULDx2ZnFKhAntbB+F7Qc6jUjO7qVUYsNCJT7D++7S/+Ir0GtYbagJTXzONwB3p2oUEcU
         KxdA==
X-Gm-Message-State: ABy/qLYO5sajlcQA9afIvOu7YvHr3EotVXYdN4LcnL9pqllG09KFuUkf
	2N9PiUkBP+9/K0S7WSSA7og2ee1oIQ==
X-Google-Smtp-Source: APBJJlErKoO+jOj/HW6ueqTUSBdz3nDWjRIUPoyP67SjYcx0c0OjPrHp1rc9rkiy/8eeqKbzuJvC7A==
X-Received: by 2002:a6b:f80c:0:b0:77e:3598:e516 with SMTP id o12-20020a6bf80c000000b0077e3598e516mr7858205ioh.2.1690802678739;
        Mon, 31 Jul 2023 04:24:38 -0700 (PDT)
Received: from [127.0.0.1] ([40.86.18.80])
        by smtp.gmail.com with ESMTPSA id d20-20020a5d9bd4000000b00790af7745b1sm261387ion.20.2023.07.31.04.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 04:24:38 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <d2bc86f8116310c2f3b2931fc3565ef7cce17027.1690801329.git.geliang.tang@suse.com>
References:
 <d2bc86f8116310c2f3b2931fc3565ef7cce17027.1690801329.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22bpf=3A_Export_more_bp?=
 =?UTF-8?Q?f=5Fburst_related_functions=22=3A_Build_?= =?UTF-8?Q?Failure?=
Message-ID: <a1de6bde-f4c7-0b58-3385-5bba8a9703fb@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Jul 2023 11:24:37 +0000
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
org/project/mptcp/patch/d2bc86f8116310c2f3b2931fc3565ef7cce17027.1690801329=
.git.geliang.tang@suse.com/
  https://github.com/multipath-tcp/mptcp_net-ne=
xt/actions/runs/5714012631

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/23c0513506=
c6

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
