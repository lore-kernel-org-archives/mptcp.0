Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D58F29CA
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 12:42:05 +0000 (UTC)
Received: by mail-qk1-f173.google.com with SMTP id o25so1421192qkj.7
        for <mptcp@lists.linux.dev>; Wed, 09 Feb 2022 04:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=6FTmcCNvflZ/ivsFm8rOYfC7pmMxlv17otXqxzDwuVg=;
        b=KC+1REzYdO8NlGfqML6SAv0FiFr+t034MQgIOjkUfk6Nlnvse0BGs85DVy/mDrSYYc
         F60iaeRWaGDj3M9o1I7nt/50A5BglrQtD6Dl5sbhzfOaR3EGDyEbYl3k2nqEtJywpRao
         K0m2C42k1Z1m5YjqZ53C4z2QEP8h12H6NGtzP5ZU4ApTxo4kkBGTfMMKqypWMzl0PHwV
         ETzDHUaETaKxT7a7zCUun6pyqx9AIODcorl7i5OvhkF5vOGfhUofODktaVkR2b9xGsmJ
         rnRqt9jbJlL8SqWlo43bWbTK/X5OJ9ygsTVUzpeOP9OIrlOv0DicOWMre3svARp7gOm5
         5Ipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=6FTmcCNvflZ/ivsFm8rOYfC7pmMxlv17otXqxzDwuVg=;
        b=uWp4cGftJJoI5iLMAC+/UMvrqXmWNXbgsiwmQiIg6dTzLbAHqz9MGqDEfX6W9nMeRT
         SNxOgRmcn4H5ofMG228R/oHjZiw+c0vptgsIBu4xa99fVkzm8w5kEcqi1mY1NbypHFqa
         KTtieXYdXjJY9XfpgVoPRs2espKOhiCqrpL2sRqaiJFkM7aDL7UraxS5yYetLAeDrD9Q
         iSCNDMXZRWzrX9Hz2bQdaxBdmzhlQhB6CFFldZWnWwG0MBk8ry6zdHUMohYCgEkga4rd
         ViL+Qwu3lBZ93QinG/GKMZzfJkoSmovIvT8QXO7DOHteE6c2cK9cHL0nR+elj56ZgHE+
         wGbw==
X-Gm-Message-State: AOAM531m4u4NEyq++Nlp+GAymbKV3j7ya1YB+UK4z2xsGSDuhRiuL6r+
	bSo8MI2kfhYKFhfylN4X5ukK4v1wUQ==
X-Google-Smtp-Source: ABdhPJzRpH+8Ixedueq/eJy4Jw9CO6SRsEUODrxQa4XbphaVdZ2CgP3a1eO+qZEOTxMg6V33KnK7aA==
X-Received: by 2002:a37:6742:: with SMTP id b63mr912759qkc.621.1644410524316;
        Wed, 09 Feb 2022 04:42:04 -0800 (PST)
Received: from [127.0.0.1] ([52.170.156.97])
        by smtp.gmail.com with ESMTPSA id bp37sm8087800qkb.135.2022.02.09.04.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 04:42:04 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <1d7dfcc6b0628ef009798298e0e5922513f30083.1644409809.git.pabeni@redhat.com>
References:
 <1d7dfcc6b0628ef009798298e0e5922513f30083.1644409809.git.pabeni@redhat.com>
Subject: Re: mptcp: strict local address ID selection.: Build Failure
Message-ID: <4d4836bf-e3bd-62ad-f245-0881ed97aff4@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Feb 2022 12:42:03 +0000
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
org/project/mptcp/patch/1d7dfcc6b0628ef009798298e0e5922513f30083.1644409809=
.git.pabeni@redhat.com/
  https://github.com/multipath-tcp/mptcp_net-next/a=
ctions/runs/1818045488

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/4d777b755a=
98

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
