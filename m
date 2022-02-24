Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58167A
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 14:52:11 +0000 (UTC)
Received: by mail-qk1-f178.google.com with SMTP id z66so1934029qke.10
        for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 06:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=Lvi5kHR7BhZKa/tjn21ffwLkXyqwBQDGBBKehbN4xGw=;
        b=Ei/VAfqYEbwwNX3czGysfz5ct5ukxlg6Uj8eid3Q0meZbnL9IgTm9c8h+FAtBeFyOb
         auAPx53yi8yPxW6mzZndrOOxrrnxGDLaJeuZ9TsnSrk5g173zW5HCiz6gd+E0XXgcVQu
         PRjGh7xtMiJPf/Eg1O4ES6vjLuClBV42lhAMWAwe/G5BmV5TRlXdLKfUy2GUFz58+Erk
         dsmmI1C0qBuvVzOvxzl7yAijgfUwkf5oYOGzio5XNzkKdbnlxThJZskSQ6kpqq50YK+T
         hzcMrLKgwV4dDtvqRwaLYbGZu6JmjoitEkOGZslfaGK9Bp1IB031LQMr+L7ka3J8cPiA
         +xaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=Lvi5kHR7BhZKa/tjn21ffwLkXyqwBQDGBBKehbN4xGw=;
        b=JtGUeP0dzk0bZpX0+3Wo+fhy1nlC6C6ZL1cbCBU+1AFdTSH3Lm2IRK3Mizd539Ye5N
         MdthkbwOybs6YNLh+CKCWofV5tSHwY7eZbUKPYnIentKyQJzNXYwWBEvVezVGLYJWAqI
         Gx8qAYIVLjtXiP9Cffzkdlq+e6UXey3mWRcNqX/qCVrJuQ4IE5mhbgnZ64tG2gnc9EyB
         BxXksGvjLXVA0wbzVkikmgmXhmxxkphRHiHAV3sG5GfOhHWNua7GCS6YPCHFGrhsCyPN
         DurFZKFwr3BbLt1UhfKNI28qmaHPZBJN6pdOqVZKyS1+gVu+bLM6fout1npYevJLv9xY
         qhzg==
X-Gm-Message-State: AOAM530kCryHePiv9UfHj4xn+mOaZ4WO/ZNe6TzoxkWeXxXFWGT3KkcN
	UyBPg3a+noaaPzO2Koo3KE6uocx98w==
X-Google-Smtp-Source: ABdhPJxhNiSV2ekzM8AAdUhpDeHs66vaws8sqH8X7fmfjb5jcqcqx/Lzj80El76lAyOCSwmGEBmaQg==
X-Received: by 2002:ae9:ef09:0:b0:506:aadb:1f1b with SMTP id d9-20020ae9ef09000000b00506aadb1f1bmr1796113qkg.609.1645714330855;
        Thu, 24 Feb 2022 06:52:10 -0800 (PST)
Received: from [127.0.0.1] ([20.114.148.17])
        by smtp.gmail.com with ESMTPSA id p14sm1517682qtn.93.2022.02.24.06.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 06:52:10 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220224135619.2523272-13-matthieu.baerts@tessares.net>
References: <20220224135619.2523272-13-matthieu.baerts@tessares.net>
Subject: Re: selftests: mptcp: join: helper to filter TCP: Tests Results
Message-ID: <5d60be4e-603f-a463-df76-95edd4c98593@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Feb 2022 14:52:10 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5434161388322816
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5434161388322816/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6560061295165440
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6560061295165440/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/c4be22d32c97

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
