Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3B922EE0
	for <mptcp@lists.linux.dev>; Thu, 23 Nov 2023 14:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfqKtnBb"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7789aed0e46so47286185a.0
        for <mptcp@lists.linux.dev>; Thu, 23 Nov 2023 06:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700748075; x=1701352875; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o7J45alar/Hrqzb73Rhbb6opHz/uXv9gK8y+2LBtykc=;
        b=TfqKtnBbBOuFw6rItLk8UPTwj/5Jojxg25naX6n/zzfEE9uBrM34YRW9r4clhfZQqD
         EcfTyoVAXqJbHVbZwaimxh1FffjziHZN/6oduHcRmCS+7bQPkNRNRNrAcxqK+bJQhZFO
         uh/qmk2Ng7EYrRbuPjjcYpvobfNooriW1J6XDJMLiDla0VCuFWlLKm4Vd4CFoXrxLa6K
         IVPfUTPXFkUh2FbsZT60IZ6X43ccUd85WQJYcqeIJcIjrc9nsHHEvXQ+I3M3qNhOUsFg
         e4Kmamr3yBbkdraYg2IdjAGdAd5CVGqD8ylnkey+QKJAEM+WHoroJ2QSFsP5OQX4NX28
         mgoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700748075; x=1701352875;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o7J45alar/Hrqzb73Rhbb6opHz/uXv9gK8y+2LBtykc=;
        b=KmeNi0SCuI9SVO8aAf+AZfG9kwci/jZYUE9yeVd5q4SrsV9Ho4Pn31OV0BQZ8rNKn/
         xA49SplkjaKquGkLISM5Xl94HtWqfZiKy9G+4beVBOh9GcWoZitnDWOxvO7HlC4A7JlT
         Rlh51LyFxVtL8xBgpgJPAyJO9goy18/CHJHJ8HiIEI06zpzj5kOJ05LCAZaC0jT4MwN/
         U4zugNrsgTirkUZu9vsG71vOV1XBXPAH1eTO5AK5NsC6VuzLjb1YIYqIuksAZZ5lJo4V
         sR98zH+O23elFJXK/h7CNHZajw+hQ457VIN6JdWgEfePPNcJEfM9D9boncN1qnH7tv6U
         c0qA==
X-Gm-Message-State: AOJu0YyNgt2AZMr4S7vGBVFepO+f8zg8Ahw+upnE6aJkPyd0ovTq0ARn
	QwZdcurxM6l+4vd7ji+iaQ==
X-Google-Smtp-Source: AGHT+IEhe7AY3OVuc9k8bAegnRWPvnBhm7HWqrKXWdXT8XmTOhFrTh1YoD4UxGRxFZJqWwaxhS5rPw==
X-Received: by 2002:a05:620a:1313:b0:77d:73fd:e845 with SMTP id o19-20020a05620a131300b0077d73fde845mr1305524qkj.12.1700748075317;
        Thu, 23 Nov 2023 06:01:15 -0800 (PST)
Received: from [127.0.0.1] ([20.81.159.68])
        by smtp.gmail.com with ESMTPSA id ro15-20020a05620a398f00b0077d6f870ca2sm473452qkn.84.2023.11.23.06.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 06:01:14 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <240a97d522887a938faeb24a6a3e3a9ed24570b1.1700667908.git.pabeni@redhat.com>
References:
 <240a97d522887a938faeb24a6a3e3a9ed24570b1.1700667908.git.pabeni@redhat.com>
Subject: Re: mptcp: cleanup state propagation.: Tests Results
Message-ID: <27d96275-06e9-f254-a848-ed7b604eca70@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Nov 2023 14:01:14 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6501777365794816
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6501777365794816/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4672190017175552
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4672190017175552/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5235139970596864
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5235139970596864/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5798089924018176
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5798089924018176/summary/summary.txt

Initiator: Matthieu Baerts
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/e29d5c16e056


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (Tessares)
