Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8264F1B75
	for <mptcp@lists.linux.dev>; Tue, 15 Mar 2022 08:08:40 +0000 (UTC)
Received: by mail-qk1-f177.google.com with SMTP id v15so14874711qkg.8
        for <mptcp@lists.linux.dev>; Tue, 15 Mar 2022 01:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=42nOlJ/xfI5pax2tyUeyBO/tB1EvsYa5aTUD2QXimP8=;
        b=i8z1k9mKRjQANagXx9rc2PrO4NXCUfU7iIj/HeofXRRaGYa7TFEm6/rc3J0qAEXkO+
         gaq+pSlssr+okqfSGd+ZJIrJrMZqoRJz2aYaT+XZQY4NC8p/ubKojcb5LM+wWItKhBiq
         BmPPmBGO6WiI+GJYSbP7j6gvpetP8xt2QliouVYFhWLA4StDDm/lvmNjUCT70abss1Pn
         ZJj31c4e+T/69bEx4s0in5G7tzJKPcNnKPVdulX5geaGjIGv8PzWtUxvpNeA3cJ1v4ep
         0bIg8iJNJ9yiKGmNPqMZGWRkC/qg8UegCRJ4ogcLuE8pLhkpuqSEACAxpHZISCxqxw8c
         vURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=42nOlJ/xfI5pax2tyUeyBO/tB1EvsYa5aTUD2QXimP8=;
        b=nd3tmIBwfYoYwNbvfWqRJByonPyqhvjoucMO8dV9OKea705/5AhOHSqCtfdqoW3ROQ
         52VyXW+3NGZKXak9M/pELwcZLaQOe9d1XtZEEOINUmdHQJN8dVdKM/ujlq9rN1hoeZLC
         iEbSJI5x7q/PCZmxseLzZFkO9MWZ62U5u73AljK3OfwobHBtvisn177XOLn7LP11qX12
         cRtoNjrIN/jZWWOydYfzFauJjJ935Ish17B7ra9AUMxz/N7srYBv0ckPEQT9Ew6Y7sp2
         IbokUT+wyIgKJBGag2ZgQNdHmOmyt0OaY0Lmg3ECI9+mZ6XjAOyhbZ/8pTZR8dlXj8N/
         Ddlg==
X-Gm-Message-State: AOAM5304jnKl8ug/ui0q3BWYL5vhQFDl7gjifcUrZe37AMvE7dytEPT8
	QkZgyZiVZbhIro5Ie4i+Ww==
X-Google-Smtp-Source: ABdhPJxPAWEyh32QCNLFemZonX1/mbPeRlEY2puH4S+uAbzZY+SuDSVqWGpcGBHDHF7xJANn8B0+3A==
X-Received: by 2002:a37:9c96:0:b0:67d:7293:7374 with SMTP id f144-20020a379c96000000b0067d72937374mr13814595qke.365.1647331719456;
        Tue, 15 Mar 2022 01:08:39 -0700 (PDT)
Received: from [127.0.0.1] ([20.119.230.151])
        by smtp.gmail.com with ESMTPSA id p17-20020a37a611000000b0067b2b2c41fasm9176436qke.81.2022.03.15.01.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 01:08:38 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <be2f8bba76fd1a74f31e23f1fd1c5fde457e5108.1647327162.git.geliang.tang@suse.com>
References:
 <be2f8bba76fd1a74f31e23f1fd1c5fde457e5108.1647327162.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: print extra msg in chk_csum_nr: Tests
 Results
Message-ID: <5ca46297-e260-4e9b-9851-dcbb8f02115c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Mar 2022 08:08:38 +0000
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
https://cirrus-ci.com/task/6750472991145984
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6750472991145984/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/4511867316994048
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4511867316994048/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/3d584c2de1fc

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
