Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEFE2F4A
	for <mptcp@lists.linux.dev>; Fri, 24 Mar 2023 12:34:02 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id mp3-20020a17090b190300b0023fcc8ce113so4885735pjb.4
        for <mptcp@lists.linux.dev>; Fri, 24 Mar 2023 05:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679661241;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXFLLaEiyLTxSA7esIwnooW9HUoF6nCGX8qTnTO7d2A=;
        b=YJ9+Z4yuSN9qbEPmW09Sfd78gurDBatQkekx2vvjLXZf2rGHm51i85mqZ/8ituXJQq
         qBZN4zKzx6gcduXu91gRxV4GKLcDrtB+OJ67fqVvu6YVwK74ICY6w5Y84NCbJlo+9oZA
         Uqhu6QasptYx5tNhoDqTyNhnlfExX4MIAbB/l+j0pq+SRNJ80XkFMQZOYB5xxZ/DzRtP
         xPJCOGRVx1OcoXhkCZ36Er3aYwrL8O3b3VHdk7QTpSuwv+ZE2WWv9+tdDOrrTKCCY9kv
         lG8PcR3Y1ZX+W7JCY6uz2vpmWZObQbWGFgozFu42o1VpMxhWB7Ylwvw138+/ajIYPikp
         yRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679661241;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KXFLLaEiyLTxSA7esIwnooW9HUoF6nCGX8qTnTO7d2A=;
        b=zewL2yQmpq0zJr0+rowtHrg0EZ77nr+7Xg6FjBSGfmz97nk2SQcP3Q1apTmF7hslAI
         7kjB0v94uYxI/cD5+RUfStF/4udtGK06Ky/PCrdsw8NFzbbqI1QytFdVbds4YPS/dWl+
         5CMSRdkMrP86C7VO12iI2UbG/IuU1OzdnjHzAstJ2XSni2n3Q37VUu8BNC70R0fmNA4A
         BWT2V4kCv5WabFufwXAl90oOvqZv0SBT/hc2OS0oh6I+cy83zEvdnmiIiQZMkYBU0Wkf
         DNBd7X3hloqhl3LlX0xWSx6fwli6z7qHCBRJ0rZs/0wuvHotsOewbFrhOvB6IBUXWOmy
         Bhqg==
X-Gm-Message-State: AAQBX9fFFo8D2S4of2iX5qWHFIPUg0UbClx9xes9QBRrs3wnEn0fBDcH
	8DJXDINiIjHeCwuwQG+rvw==
X-Google-Smtp-Source: AKy350baczV7C69KamTDJkNPMa4k/utfzkV1g0hbZ/7CqbqHe/rj6vlTQAIXF9AuDzWRuLqiQmEJwA==
X-Received: by 2002:a17:90b:4b47:b0:23d:29c7:916f with SMTP id mi7-20020a17090b4b4700b0023d29c7916fmr2651436pjb.32.1679661241468;
        Fri, 24 Mar 2023 05:34:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.88.61.236])
        by smtp.gmail.com with ESMTPSA id p20-20020a170902a41400b001a1f5dc64e5sm4606936plq.177.2023.03.24.05.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 05:34:01 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <10b158069455d831d9efc547bcdb3a6379234f1c.1679654040.git.pabeni@redhat.com>
References:
 <10b158069455d831d9efc547bcdb3a6379234f1c.1679654040.git.pabeni@redhat.com>
Subject: Re: mptcp: stricter state check in mptcp_worker: Build Failure
Message-ID: <2f3ded10-e9f4-07ca-3253-3534b34f9a74@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Mar 2023 12:34:00 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/10b158069455d831d9efc547bcdb3a6379234f1c.1679654040=
.git.pabeni@redhat.com/
  https://github.com/multipath-tcp/mptcp_net-next/a=
ctions/runs/4511121675

Status: failure
Initiator: matttbe
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/0a8809a9f3=
ab

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
