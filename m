Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FDB377
	for <mptcp@lists.linux.dev>; Tue, 12 Sep 2023 13:32:58 +0000 (UTC)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-76ef8b91a4bso356118085a.2
        for <mptcp@lists.linux.dev>; Tue, 12 Sep 2023 06:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1694525578; x=1695130378; darn=lists.linux.dev;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svmbrtqWlENrRfjFLkk8+XzIqzX9R6UBCXGlZ2j0y4U=;
        b=FAhlJ8zMFXh0EM8IieAj9qkYDSMFpthWOF+/k0M3oAauEwRYEW85BWKTuIJPB914Mz
         whN8u5p9ZRgV5BtdnpTfOivU96byZrvfJcJGFwDlG90S0qneUO0FcxM/zvDDiRISHjJZ
         ZxhpKx97MwWm7dicuE1aGiWbeqi9MQARLBJKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694525578; x=1695130378;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=svmbrtqWlENrRfjFLkk8+XzIqzX9R6UBCXGlZ2j0y4U=;
        b=NwlHinqnIgzEjmaXo7ddPUoN1/riNlEhzee6kBZ+hcurlJTnH4t6jAZUZP9+UnL0Rz
         2EuQBO7h4KZLX30N5U1Z3ksv8n7zk9YZ9Zl8KreZcUEKQoaJVz9h0l1qeflr3p0aa62z
         OrcKDoBSMHEqI4JQsWq1a1kt0s+QczNYYeTk4ZL6dpBcOe8lr528a5HU5DoZ6/LVfbZ2
         uZ7de7OJ99W5cpx2s8FUqknd3QJBTV5qHc3er8K0F/6WpFlbP8a95WBy+UcKjBEIG/jO
         34Q0tgLLNUcXhqw02JXHZQXiLLlVbCJpZIVKpBArPT4ocfPLYtGwQhSkMPLgWunrXw2m
         x9LA==
X-Gm-Message-State: AOJu0YxPt8fRqt8B123bqsjxDjiN+mRuMaYmXmZnpO3/Sb1/N4PBFpug
	zgH2Ry7ytxx2ebX30MawLROnADFlEGdIlnFseFQ=
X-Google-Smtp-Source: AGHT+IEWmiZ0EGY1O/9xetI5jQSsVfvw8K2frb4QEsfc2ct2W79miQrJDwoAIrb/amscRDLXZA6ZgQ==
X-Received: by 2002:a05:620a:19a7:b0:76e:fd91:5f6f with SMTP id bm39-20020a05620a19a700b0076efd915f6fmr14641824qkb.37.1694525577897;
        Tue, 12 Sep 2023 06:32:57 -0700 (PDT)
Received: from smtpclient.apple ([45.88.220.69])
        by smtp.gmail.com with ESMTPSA id pj24-20020a05620a1d9800b0076e1e2d6496sm3203685qkn.104.2023.09.12.06.32.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 06:32:56 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (1.0)
Subject: Re: kmemleak handling of kfree_rcu
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <6bd9f6cc-84d0-4f6a-bfd7-912dcb8e476a@tessares.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Christoph Paasch <cpaasch@apple.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 MPTCP Upstream <mptcp@lists.linux.dev>, rcu@vger.kernel.org
Date: Tue, 12 Sep 2023 09:32:46 -0400
Message-Id: <5FAC49DB-0849-4F83-9802-571E62819ACC@joelfernandes.org>
References: <6bd9f6cc-84d0-4f6a-bfd7-912dcb8e476a@tessares.net>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: iPhone Mail (20B101)



> On Sep 12, 2023, at 9:15 AM, Matthieu Baerts <matthieu.baerts@tessares.net=
> wrote:
> =EF=BB=BFHi Catalin,
>=20
> On 06/09/2023 19:15, Catalin Marinas wrote:
>=20
> (...)
>=20
>> I had a patch already but got distracted by a few (real) leaks reported
>> while testing it. Feel free to pick it up and change _ignore to
>> _not_leak if you find that more suitable. Well, it would be good for
>> Christoph to test it as I haven't managed to reproduce the false
>> positive.
>=20
> Thank you for the patch!
>=20
>> ----------------------8<--------------------------
>> =46rom b25350cb6f8a906a6164b625bfd57021190cb105 Mon Sep 17 00:00:00 2001
>> From: Catalin Marinas <catalin.marinas@arm.com>
>> Date: Wed, 6 Sep 2023 17:52:45 +0100
>> Subject: [PATCH] rcu: kmemleak: Ignore kmemleak false positives when
>> RCU-freeing objects
>>=20
>> Since the actual slab freeing is deferred when calling kvfree_rcu(), so
>> is the kmemleak_free() callback informing kmemleak of the object
>> deletion. =46rom the perspective of the kvfree_rcu() caller, the object i=
s
>> freed and it may remove any references to it. Since kmemleak does not
>> scan the tree RCU internal data storing the pointer, it will report such
>> objects as leaks during the grace period.
>>=20
>> Tell kmemleak to ignore such objects on the kvfree_call_rcu() path. Note
>> that the tiny RCU implementation does not have such issue since the
>> objects can be tracked from the rcu_ctrlblk structure.
>>=20
>> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
>> Reported-by: Christoph Paasch <cpaasch@apple.com>
>> ---
>> kernel/rcu/tree.c | 9 +++++++++
>> 1 file changed, 9 insertions(+)
>>=20
>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>> index cb1caefa8bd0..2ac39b5705df 100644
>> --- a/kernel/rcu/tree.c
>> +++ b/kernel/rcu/tree.c
>> @@ -31,6 +31,7 @@
>> #include <linux/bitops.h>
>> #include <linux/export.h>
>> #include <linux/completion.h>
>> +#include <linux/kmemleak.h>
>> #include <linux/moduleparam.h>
>> #include <linux/panic.h>
>> #include <linux/panic_notifier.h>
>> @@ -3388,6 +3389,14 @@ void kvfree_call_rcu(struct rcu_head *head, void *=
ptr)
>>        success =3D true;
>>    }
>>=20
>> +    /*
>> +     * The kvfree_rcu() caller considers the pointer freed at this point=

>> +     * and likely removes any references to it. Since the the actual sla=
b
>=20
> Just in case you didn't send this patch, checkpatch.pl noticed that the
> word "the" was repeated in the comment here above ("Since the the actual")=
.

Sounds like you detected a leak in the word the. :-)

(Sorry could not resist).

 - Joel


>=20
> Cheers,
> Matt
>=20
>> +     * freeing (and kmemleak_free()) is deferred, tell kmemleak to ignor=
e
>> +     * this object (no scanning or false positives reporting).
>> +     */
>> +    kmemleak_ignore(ptr);
>> +
>>    // Set timer to drain after KFREE_DRAIN_JIFFIES.
>>    if (rcu_scheduler_active =3D=3D RCU_SCHEDULER_RUNNING)
>>        schedule_delayed_monitor_work(krcp);
>=20
> --=20
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
