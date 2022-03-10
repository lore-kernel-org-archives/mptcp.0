Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CA17A
	for <mptcp@lists.linux.dev>; Thu, 10 Mar 2022 09:58:33 +0000 (UTC)
Received: by mail-oi1-f174.google.com with SMTP id j83so5395749oih.6
        for <mptcp@lists.linux.dev>; Thu, 10 Mar 2022 01:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=RfyaZH2oVfYKoY6Lbx77VfeVq/swlVrtWcUgfsaAn04=;
        b=RDf94teBiUNhVafjWuXT3TN2tGQQF6FsXdrLqYRpYLA6CYO7tkluf261RFfcMN0BYW
         5B1GwGNqBNsr09pdMrVFa9Ci/SsidP6OLCk7QPMd9miVlJc/sc0sUoMYVVcyMH6k6dt+
         DSIwwXEivLE/1mOiCzcLGMpmwfzp8nzXEluv4HuilRezvbusBd5Ta+ZBv1kUtcKXE+s7
         JnpJMfw+WGI9usE1OatuThKWP9HUBNtejr3v6xY4KZ96GJcqTuYSpOn4pzS4Gy5ftjJ3
         Ic0lqerDo5GRvhVJh8xjZPfm2w7KdNFJfIHp24fIE4cAC2GoYYGHcM7ffGSl0TFhZUra
         zexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=RfyaZH2oVfYKoY6Lbx77VfeVq/swlVrtWcUgfsaAn04=;
        b=gv1p7aJ/GVuM+KVrPwwaOymUIC43yQ23oq3HrSnBYo/xaYxlbMmQGKYnRO9zc2/f3F
         G13kGv/j4wiZcjE4L/t1JY/bpDqzTQNLYB1MZazwYlBna8VcxVY9G8toN1cgUT+5b82K
         mI6G3sJSv/NEYNlXa1pNWocLt+iTecdsXQa5LqM4jIgBodfK4eQcDRSc6R/aX5qeuRuD
         L01wuUQE6M/gvhmoqIDqygcpM4GILVqSh488hvBK13i67c00pkz0FXaLbkBvytwXW33X
         JINsXT2IAxm5iI7ELCaZ5V0/EJosM0HoQvw2wFB9dWFX9RcCYuFTJXnW0ay4aB9yXkWZ
         bXjg==
X-Gm-Message-State: AOAM533c0RsIqlLL9jNOOcu0GEEopp8HRIZSeS4aLlxL2znHl+J+vy9t
	NfJzoA2uEe27hEpfiZZK5Q==
X-Google-Smtp-Source: ABdhPJwX6PKAEl7LaMSANTn4Z5+TbVNcAoV23GhJTLVgV6esx+Gt7XZvgjM6RgX5F1PUnONkhn0XGw==
X-Received: by 2002:a05:6808:2308:b0:2da:496e:ca0d with SMTP id bn8-20020a056808230800b002da496eca0dmr3437466oib.12.1646906313064;
        Thu, 10 Mar 2022 01:58:33 -0800 (PST)
Received: from [127.0.0.1] ([13.85.15.252])
        by smtp.gmail.com with ESMTPSA id p14-20020a9d744e000000b005b235f5cf92sm2073942otk.65.2022.03.10.01.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 01:58:32 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <f0b54cd0233d236cc42637b0d759e7037630b23b.1646898548.git.geliang.tang@suse.com>
References:
 <f0b54cd0233d236cc42637b0d759e7037630b23b.1646898548.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: print extra msg in chk_csum_nr: Tests
 Results
Message-ID: <4d1d8899-db99-0702-2ca7-33fb67e162f3@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Mar 2022 09:58:31 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5981420215599104
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5981420215599104/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s): selftest_diag =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5418470262177792
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5418470262177792/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/0f7e3bc359ca

Please note that despite all the efforts =
that have been already done to have a
stable tests suite when executed on a=
 public CI like here, it is possible some
reported issues are not due to =
your modifications. Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
