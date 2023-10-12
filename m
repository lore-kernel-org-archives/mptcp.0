Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939213219A
	for <mptcp@lists.linux.dev>; Thu, 12 Oct 2023 17:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4Wz2QSD"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-777252c397cso84199885a.1
        for <mptcp@lists.linux.dev>; Thu, 12 Oct 2023 10:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697131246; x=1697736046; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCAfAdAn5M7tJ4MB1TDwzWi0bA5oYgrSyli/1G9BbWI=;
        b=L4Wz2QSDlYWC3QoThmanFk2ArqG09hmfp7MqDzMW04uPK8ujU3Y35ZMTMkQ87uBKWn
         psYVXrmyJy1sdEcG/J80kUJY30AH9hMYF5OXInnjB8iDcuNKNQ9dhXmsedXGY4+tb+T/
         AJyRvrpdcFR9gA855D368kt54jZGx3RhljpmhUCo24ljTqkXAlPwoRvT/Mo1msItjamh
         rMw6UeR84Wpu/vy6NngFbOouXXcG3dpg3SPMRVx6BEcNVPQ2J2DDqhU5c42it7fzSTS7
         9D3Usp5atBAP3RdnJ4ePO7kFUfLsdvkK7/wmRDhNM43hQywbTQt9EQZAQYB+HaE9OD8G
         +Bpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697131246; x=1697736046;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aCAfAdAn5M7tJ4MB1TDwzWi0bA5oYgrSyli/1G9BbWI=;
        b=tr/WdbkMltCQH1Z8ygtiDbSrRe0wOu5RrnGPAujQHkcCc/OPNX/5SLIF8GWxzwuCQd
         3nAUFqgWqL3VW51iHKRwAbvdrPlEb/AWuyS2Uk1l+5Gu7qgW0StBJuVPXYw/1otwKpoF
         i0qs4mXeJaZPdgIEbAYx/dFf95hcdqkW4evbHZ3WaVqzEJwShnzJrDK9sVRKmy85qVRG
         MX6m4ly+o7+pL8JpbqivrWbvHXggGAnemuApkr4gRLt6PZmI/+ZYqPcHs9rDxaHMghNG
         BqInYlGZIXoRnZn1GZ3rt6ObklAw8Ti/Gi826bPkgjkUiZCfzSOBbuZ3QBXViCPshr3Z
         8hjg==
X-Gm-Message-State: AOJu0YxdS31uaEJLxbZ2K/8Wxc8EX3zUOYRfzAL9m2kS9oVA8G8rmVV/
	IrG5i+AvV2BlIqZjXmtQZw==
X-Google-Smtp-Source: AGHT+IGNQmvCorNJwyAblS8luUYiWXb/rmkT1pCQbWZL5UwQb0S6rbAgEkjjnHfn5cWAVp1Tz1fRsw==
X-Received: by 2002:a05:620a:394f:b0:775:6a43:931d with SMTP id qs15-20020a05620a394f00b007756a43931dmr30078844qkn.25.1697131246178;
        Thu, 12 Oct 2023 10:20:46 -0700 (PDT)
Received: from [127.0.0.1] ([172.177.106.96])
        by smtp.gmail.com with ESMTPSA id pi2-20020a05620a378200b007677347e20asm6127909qkn.129.2023.10.12.10.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 10:20:45 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <0ee2a306b00ef868b993e2426d9d51e14882bd72.1697125647.git.pabeni@redhat.com>
References:
 <0ee2a306b00ef868b993e2426d9d51e14882bd72.1697125647.git.pabeni@redhat.com>
Subject: Re: mptcp: more conservative check for zero probes.: Tests Results
Message-ID: <bcca1bc3-5338-d447-7fd4-d01cd1c52b38@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Oct 2023 17:20:44 +0000
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
  - Unstable: 1 failed test(s): packetdrill_regressions =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4961680967335936
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4961680967335936/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5465023217139712
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5465023217139712/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5307054319992832
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5307054319992832/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4744104366571520
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4744104366571520/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/ad0d08b0ce05


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
