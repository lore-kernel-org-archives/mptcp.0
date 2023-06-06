Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F9F5685
	for <mptcp@lists.linux.dev>; Tue,  6 Jun 2023 07:21:14 +0000 (UTC)
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3942c6584f0so3948766b6e.3
        for <mptcp@lists.linux.dev>; Tue, 06 Jun 2023 00:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686036073; x=1688628073;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1tpU8ZqVMZ8KpDqQxPweNZnRvEAWMRCv8S+hDyTC2M=;
        b=B/1ndOodqxjExRYOyxcPuPeaa3WO2CVpPT3J3WBkDVNTwcDtPi428yFONvoEIPLm6C
         aOZPaYr9dRf9Tp2MD3dxsjOTiuuYSZXCJvB9KimhH2eAU4lJhuiOyVfzyzhmZvkXvwai
         rH8An/6QwothjQnVbvczn9xHrp0p6YWyrmULxN9BiRACtNqCEcM/m+wrWoFTyFUK4yVF
         PBZLCNiuoRgsak+YGAuoI2cBLRS8RDUsuWkNMeijfwHq2xQhpQxJIWZUfz1IbgX3GQ7J
         XHS/fN4DMPXeYTPvXGrclqt9PGq7rZ9kkh0t02ckQxYmACVP3L7+ZH75iXwIwdaHlLDN
         Qy9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686036073; x=1688628073;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z1tpU8ZqVMZ8KpDqQxPweNZnRvEAWMRCv8S+hDyTC2M=;
        b=EpNOZ/zxFQ+mNMn5j3pOTF8RtxhJ9xYJ+LFKMKRt3wQo9K9XJYZ0g8ey0OxUN4nP7M
         rZOWMrhN4cTRJM1PaHhms+C1Hqb2G5eZ3gJOJ9rduIBAKdAmGwBoHsRZVe4V3v+2zkeg
         Ezlgk7Hsit6Du6pqBP6TitsZx11o/Jm8elzDpL9zrZkYMNIClT9dUW0dmCphAfMGohbM
         ilWVO0wWapf1FKO+wtW5L+wnc2AkfkXmUE54jFfgMs+jTktV5GxTUOfj5s0Dfdau0vdj
         vU6hyKiyLawpKla8f+3ZuOCbZgQV/yGkZrwhpH/AYktvktRgWUGtBfkOmPYTVZ+qteQU
         ULYw==
X-Gm-Message-State: AC+VfDxvSbQgWJy9Fc1HSJmoNFs/ZecnS4x1QtVQvXBjSHGoW0yoygGq
	mQtIaiAyhN9p4/jDPP++eg==
X-Google-Smtp-Source: ACHHUZ7BGR0iRJWNWXVe90yfyZHFC6mJ+3Hm5o9sq5PFbT1kFxP5sz+ssCi1IlbES0t4AdO9l1kzEQ==
X-Received: by 2002:a54:4792:0:b0:39a:427a:a315 with SMTP id o18-20020a544792000000b0039a427aa315mr1209896oic.2.1686036073560;
        Tue, 06 Jun 2023 00:21:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.44.113])
        by smtp.gmail.com with ESMTPSA id c10-20020aa781ca000000b0062e0c39977csm6229332pfn.139.2023.06.06.00.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 00:21:13 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <1f005b865aafc8870ca7f8a7c4cc99b7964562e3.1686033694.git.geliang.tang@suse.com>
References:
 <1f005b865aafc8870ca7f8a7c4cc99b7964562e3.1686033694.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: Add bpf_stale test: Build Failure
Message-ID: <2a7bae61-aea0-8c39-f3d3-ddf874dfc85a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Jun 2023 07:21:12 +0000
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
org/project/mptcp/patch/1f005b865aafc8870ca7f8a7c4cc99b7964562e3.1686033694=
.git.geliang.tang@suse.com/
  https://github.com/multipath-tcp/mptcp_net-ne=
xt/actions/runs/5185546636

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/08d4cef6dd=
8b

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
