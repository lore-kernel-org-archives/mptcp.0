Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0715D368
	for <mptcp@lists.linux.dev>; Fri,  8 Apr 2022 01:57:10 +0000 (UTC)
Received: by mail-oi1-f181.google.com with SMTP id k10so7558868oia.0
        for <mptcp@lists.linux.dev>; Thu, 07 Apr 2022 18:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=pBkLZBhvKr0K3mFITrKD9nt5OZ+bpYbZCLBWUjMlhWM=;
        b=FuW/qnwxSjDN/2/0fap1CrIqRjgZ9EO5OOmZfaElgQdS44CBsB+AkHKg8efLsZFwKy
         N4g29jkGkxv+LK6Y0oXK9xEGk5JKbGTqH7iKjUe/1A1Kwh/hyzTt4B5apFbwCIiErAlF
         3WWd3B/qhdKZlVjlr2qj6SEbdPvKXigE8jUEwi3A7XzANnp5PC7TuAKkaKWkxqOwm9sM
         hGWk80SywAqbTGBN2Gw8zK/akzy8KxHtpH0IjynFnEFOwjgxH0vDDfGegrALgLRLs6a3
         FFYty/itS8aB2EzDfOBKmqnItptZ5ujQ7zDEcxfJE0Gdgk7AWmNmUulgwvcPIt0ACDjd
         ncxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=pBkLZBhvKr0K3mFITrKD9nt5OZ+bpYbZCLBWUjMlhWM=;
        b=FObO0UlVElMlVy9BYwRRk419d9oRjQPVkokdgCbbP4VS8Ii9dzMuh7RG4gk5ghedgy
         1qqDdy8ijmvKjXbCw+/yHPzUerh4wnAb8ECnpchiyYdU15MgaT59bSK3h9BUJc5dzH0o
         aBZwHT7eAzqZPxf7Hb8j29OZjZM7ABOl0vQPPz5pZjMqEeAKnbc+iJw9BhEHnnMHlJuM
         JrVCHfyNe0E1ekqnkC8UiInhnTxBIlZMekq0fSKSh6nChh7PjjtnSsVRS7a6a2lLr65j
         BQ8/OBvAPqoXZ/MYD61s/pPKQ58iEaef7JfOKVmcGUhpC3wbcS/FeUAvqN+P+AexAe3B
         BqYw==
X-Gm-Message-State: AOAM530vXPj9hPhAd5ua4ghbI7jpqMGYk8Hugiux9Iy7FnsE6xWDcy8J
	hJ03ivTAcSjE6PTYRAJxKw==
X-Google-Smtp-Source: ABdhPJzOH7GdDjbdpbeZJWkqV90y7CU/OMiR6pJivoEyt0QfJey8WIYZGYayOYkwB0fBAo6MmX6VRQ==
X-Received: by 2002:a05:6808:1b25:b0:2da:32ff:ab73 with SMTP id bx37-20020a0568081b2500b002da32ffab73mr6981338oib.285.1649383030031;
        Thu, 07 Apr 2022 18:57:10 -0700 (PDT)
Received: from [127.0.0.1] ([20.225.98.39])
        by smtp.gmail.com with ESMTPSA id h11-20020a9d6f8b000000b005b230ab0461sm8585639otq.64.2022.04.07.18.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 18:57:09 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220407234029.1774481-15-kishen.maloor@intel.com>
References: <20220407234029.1774481-15-kishen.maloor@intel.com>
Subject: Re: selftests: mptcp: functional tests for the userspace PM type:
 Tests Results
Message-ID: <0fad9a2c-ced8-f28b-9582-076ec7ff6b5f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 Apr 2022 01:57:09 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Kishen,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/6670539791007744
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6670539791007744/summary/summary.txt

- {"code":404,"message":
  - "HTTP 404 Not Found"}:
  - Task: https://cirrus-ci.com/task/4629846209855488
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4629846209855488/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/2c3fdb5eab10

Please note that despite all the efforts that have been already done to =
have a
stable tests suite when executed on a public CI like here, it is =
possible some
reported issues are not due to your modifications. Still, do =
not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (Tessares)
