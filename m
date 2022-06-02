Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FD8622
	for <mptcp@lists.linux.dev>; Thu,  2 Jun 2022 05:20:49 +0000 (UTC)
Received: by mail-qv1-f47.google.com with SMTP id l1so2943224qvh.1
        for <mptcp@lists.linux.dev>; Wed, 01 Jun 2022 22:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=fq0hfuiGCE33UO4zEAaQgv/kBQYgAPuH96mfeAu5PQI=;
        b=mQ5T0mXRMVRR5LsaVKixtpuZ68hxjcrGBKfP6X3L61AuLftrJbZSSWBZ7TyKrGOkLI
         NBcTlxZGUuVbE/QTMnMWIdfw+9vyuU0gV9dYQa075BAAGdsPwkI43XIbq3ZMevap85FJ
         FIxOCSP0La1rTAo1oq++ckfCwyGHPkM5yuXKmZIxQxbqkGEKVl0yhmFNHBeh6M8voxu1
         s3xmf5EgsSVIEQNCY8uEjs86p08mhcG9XCWq4i/j5UquF8QrMShQiQpypWfNy7tDyY7g
         Jws12Xg3reh+5XgmRl4t1X5gfc4RYn6JK93j/k5dUAzw0g3g+EZY62e5oUHeBjxXLRT6
         UICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=fq0hfuiGCE33UO4zEAaQgv/kBQYgAPuH96mfeAu5PQI=;
        b=4MIs4xdHRu16/5FFwxdAMcm1t3v45bPK7IeUU+vi4qSj2trkFYbB8wfnMF5qQrTiyn
         qhHZ+b5tkqkIjVuhP56AlVfKgshXlEZ6o4JCfsmGjZL3zDKT9aSIFQtS8Ms8oBlNyZIv
         6jUCk6mNAmswTZ4eZ1G9ithKGqjT6+vW6zGL6OcQ+goxLMYvA+MItDoC2Qgng27VENbD
         57qekg54sqWD26w/pktlx8Dytg88Auc+rIhEfDRPX69Dfv3Rpe7jZySyjNqxV1WPzgsj
         nCjDVxP8ov8dDM3At09XqnS3sUxv1cho+hx4iMNdJMqfUG9nJDkJ5/chiIhiKuIWTrEM
         Jm4Q==
X-Gm-Message-State: AOAM531O7sGoMFz9UxVHAyIFhld7+bMvVIhRHTjcjYmsdZXJBHly9ZZG
	W1t8tkx83oaFq4j6oYMoKYxozFYq92xe
X-Google-Smtp-Source: ABdhPJwOkF1pPZa8TLCp5qLYfjt5znKMktE21XBjQbCdPuJkNfF9w85AXiCAfZkhkENuhcczSYHKUA==
X-Received: by 2002:a05:6214:c2e:b0:464:6156:241a with SMTP id a14-20020a0562140c2e00b004646156241amr9611134qvd.51.1654147248537;
        Wed, 01 Jun 2022 22:20:48 -0700 (PDT)
Received: from [127.0.0.1] ([20.246.17.12])
        by smtp.gmail.com with ESMTPSA id r203-20020a37a8d4000000b0069fe1fc72e7sm2501335qke.90.2022.06.01.22.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 22:20:48 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <f26165cd8b5d4380c16b4d13607e219e376bdb19.1654143895.git.geliang.tang@suse.com>
References:
 <f26165cd8b5d4380c16b4d13607e219e376bdb19.1654143895.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: Add bpf_rr test: Build Failure
Message-ID: <fd4fccd2-81d2-0cd7-e727-0bcba4435e2f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jun 2022 05:20:47 +0000
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
org/project/mptcp/patch/f26165cd8b5d4380c16b4d13607e219e376bdb19.1654143895=
.git.geliang.tang@suse.com/
  https://github.com/multipath-tcp/mptcp_net-ne=
xt/actions/runs/2426166438

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/09f1dd4b0a=
46

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
