Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com [209.85.160.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981052C85
	for <mptcp@lists.linux.dev>; Thu, 14 Oct 2021 15:01:36 +0000 (UTC)
Received: by mail-qt1-f195.google.com with SMTP id w2so6065899qtn.0
        for <mptcp@lists.linux.dev>; Thu, 14 Oct 2021 08:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=/KaRpbutY7Jqik6obbfqL5YL/XAg5WU9ygPwf2Hv6Es=;
        b=gIaJ1gB8UTg0lKau9PkZxE2vBWZLTx0xBTfm+l8TqaGqjlz55XgSJOc+ayggdGxLgs
         nsvkBluVf+ImJWlY5KdbOW0qJepc+e93nVJOIr+yqz8S4hsHwTxMrQPO0i9n/DKjcl9q
         oI16xc2GdVXw8sJfViD1/HO4iZ4m4odCsTdxNpGFO237jdZimeXywalCffb6uqWaeb/1
         7VbJnlCffLvE9tTIU4UBRam2nvisbP7mmys+HW/WDM5vIEsGVyUuyOlYbTi+5dv9ovLr
         HB/G0BZpWz61dlYqr3YpHbgkOxxQOwl6bJ5uCvkCoqLWYA9yuXMKOtlonwD2NCGqwU61
         qqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=/KaRpbutY7Jqik6obbfqL5YL/XAg5WU9ygPwf2Hv6Es=;
        b=QjvpzZaU6u2+XVakPCdoA66Ap4Mk5A2TaU3BOtao7/HidVvZN4sHegu3akwT6Y7hNn
         a4wiN5NIHRWhu3DZDoemjBsLRdQ4ayHSMwZd/J3A3DTSgfZ1KNA0rFq769nlMPMDcPD3
         hiH9qUzyAmdFVkxQUpaHN3UeUx3hXAX4KhhpuMjMq1qJM2kRLrmGt16F4WIEHRG00eta
         TXJ0d0wXtsy1vuyeQdU/wi+H7LUX6GewG2abJC+KF79OrShrPmuuRyQTAvtMSNcST13w
         0Qz/jSQIQYzJqiuug4HzPKu5ZVAAJoIM9+zJTe7qgqMcLkcgP2N0+H/TSkynNMmKScgP
         f7Ew==
X-Gm-Message-State: AOAM533JS2GLCsd/ht8+PColiAp9rtJ8bp9Nx17KBGuX0hECqJxL8Qrb
	9EI7P2+GNwRwvIAMeNCfcmPxrEsXeShMN+c=
X-Google-Smtp-Source: ABdhPJyW2eY7bd+ni1poZA+oZOcRCe902WGqB7TziyvFlmN3O2loIbJqwCh3gofPeMaJRchqaf6qhw==
X-Received: by 2002:a05:622a:4cf:: with SMTP id q15mr1278555qtx.265.1634223694733;
        Thu, 14 Oct 2021 08:01:34 -0700 (PDT)
Received: from [127.0.0.1] ([52.179.198.131])
        by smtp.gmail.com with ESMTPSA id x125sm1406358qkd.8.2021.10.14.08.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 08:01:33 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
X-Google-Original-From: MPTCP CI <noreply@github.com>
Content-Type: text/plain; charset=utf-8
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <Matthieu Baerts <matthieu.baerts@tessares.net>
References: <Matthieu> <Baerts> <matthieu.baerts@tessares.net>
Subject: Re: DO-NOT-MERGE: mptcp: enabled by default: Build Failure
Message-ID: <4a44944c-cf5d-9e64-24fe-6cf78ab9938f@github.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 Oct 2021 15:01:32 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hello,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://github.com/multipath-tcp/mptcp_=
net-next/actions/runs/1342318382

Status: failure
Initiator: matttbe
Ref: patchew/cf3710062ecac93e469306b3ed59a70688d36620.1633451893.git.=
pabeni@redhat.com
Commits: https://github.com/multipath-tcp/mptcp_net-next/=
commits/patchew/cf3710062ecac93e469306b3ed59a70688d36620.1633451893.git.=
pabeni@redhat.com
Tree: https://github.com/multipath-tcp/mptcp_net-next/tre=
e/patchew/cf3710062ecac93e469306b3ed59a70688d36620.1633451893.git.=
pabeni@redhat.com

Feel free to reply to this email if you cannot access =
logs, if you need
some support to fix the error, if this doesn't seem to be=
 caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
