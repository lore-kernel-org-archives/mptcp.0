Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5107530CD82
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 04:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780029036; cv=none; b=MFc27Rg3df0RvZZOEUoqhHcfbhs1gaF0w/4+SrkFid3BBcXNtLy5iw8k8N1z81xfc1zf3OsA8zykvUh5qxOVZXcIMmAUSjNPT+lkiyuEtldJA/Y4tyACXDoCG9+jlzZq78Bmv4PrIW60NBX+0vRkSDgpmuGy7oS/ajF0nf/MHVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780029036; c=relaxed/simple;
	bh=wxoa2M2Z+ZvZS9q9LTYW6uanRFhKg5Qeeu+PU7Z1Mpo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=N7xCQD3CJuk/TBxHlALNZsys69QhGMoQEsHtFpjCSpJID0GrKw0LqvXAVwH6+Pzu0G3yzvbLxBxOc63PBkdW6xHJrrY2fy04qockhHXsi5E2kvSYtzMkvSqIMAoAj+zK/dU/4oMz5gqPGhaQxNSn0dZrpJVEQVsu0+pR6W8Mh8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kenKbfht; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kenKbfht"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-91066394ef8so1020641285a.1
        for <mptcp@lists.linux.dev>; Thu, 28 May 2026 21:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780029034; x=1780633834; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uu0rS+d3/HQiDAghGjYh6laBIuhEXILNcv9r5KLxXEw=;
        b=kenKbfhtCNGNnydMly/H2zY+g6YNGjXk9QkBkpROd6SHHwhmGkNk7LIewjv5WilBAR
         sXhUqPfu14fu8nOtw5JihyIWiq4camIaXAzmu1qSlgmFMSAByQmsu3nyHDJWa5OjCT49
         iZ1dAc3PrE/qKBkkWqZCB+vL5Q2D59AiaPAXQxp33XrmNPtSJb+jga0FG8AWaEJNRKjc
         Li5wnATmEDvKBxC3ZkdCmEpA2uR+7Aez1EioOVj+6aEb9Vrko0EAxclP0ScuQt9WUD7i
         5j2y3TVNjEWgkC9HVi2t0mzwKAwsyNM6asi8GpUGdX2NKXqhTh9TJe37rKkH0rhfP3wr
         WxCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780029034; x=1780633834;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uu0rS+d3/HQiDAghGjYh6laBIuhEXILNcv9r5KLxXEw=;
        b=arAN1R8Oc1cpuRGn0Tn2ExpmgUwJ/XA1e4IU44SPFbD7sd30gnZTeHUBPzWsUpyNij
         n/mLxfhneEuMEGZf5w4IAurtZMLXVRArmTNz1gvuwXSHwXWxFSXOvSE3bVeOHQnQ3TDh
         jjxsWOXzmyGQZKvCLlQ2opqV8CYGU2Fm643r2HShSwtbX1MSsytzJMHAdLEPBiO30oCz
         iPy3W/XNDOedsS8SoBp+e3yuKfbJx9BSDrtyjGuXnoN90DPBtRbsB/HFi8nskamch+Z4
         JM3dR8kGi37yaqHbGEnRW4iHbOOg+xdiqtavMrmY7d1ohAoE4QQvyNAJylaGZ1Ytbt3w
         1VAA==
X-Gm-Message-State: AOJu0Yy+9Emk74Wss+bM4CxX3JrAMpmlFG43kcfdRAhrbMB67CyUaftt
	xNauh9Qbv9lAuHb9KKr9S9UD1jYDph2OwtmN+ZRd1ffgry+JG9tIwYA=
X-Gm-Gg: Acq92OE7pQcMgXgU4o9MZ7X5r1b74VCHQ/ro4D0XJFLCsEm5PRL8GFh1D0X/gC1Wafq
	FRyY+g54ntYRSKhOOfCn1HmSa8ioE6F/wSPmPRTBsdCNOqwa9ZjYriTa577rKxGylTHSHDP65dj
	lSRbXlYqlAt33jVkz28f67fGPe79FFQXvTd08jXBzX9Spee8Tr7hAfD0+LaoQ9JvL1JXz0afkWI
	FHPpMHIAIEQFyq9GHJIHD2j0V/PBLBDQCkZmTlNPcxMkgtatFAgX/evcqQkarHen1SYYzvdqpKl
	EcJNSnl1ZAKeGIS++euX/ao/pu7k4SNgDZdjNpnPDhBaPinykCuU1jm7ANSOe3R1Iy2WxnqJVLb
	AXNHSc+PkXja3G6dhea/PWPxAfG/O1NoIpIUOt0iiWMfXwcQvFZZm6qmeyawbBfzR1HVJNtI1qI
	ikq9cE9AUMQ9pl3YB/f9YSwG/r3wG4zWN9wgdv+VCc3aIUpbuo
X-Received: by 2002:a05:620a:19aa:b0:914:bf8a:ba72 with SMTP id af79cd13be357-9152fe3b6f2mr151004485a.57.1780029034205;
        Thu, 28 May 2026 21:30:34 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.45.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9153260118csm53688885a.27.2026.05.28.21.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 21:30:33 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20260529-mptcp-add-addr6-port-ts-v4-0-cea393fa33a2@kernel.org>
References: <20260529-mptcp-add-addr6-port-ts-v4-0-cea393fa33a2@kernel.org>
Subject: Re: [PATCH mptcp-net mptcp-next v4 00/15] mptcp: pm: drop TCP TS
 with ADD_ADDRv6 + port
Message-ID: <37f8d86f-44ae-0195-3a74-bce074db3b51@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 04:30:33 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_add_addr =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/266164=
64627

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/50fb9dc2cfe6
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1102593


If there are some issues, you can reproduce them using =
the same environment as
the one used by the CI thanks to a docker image, e.=
g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" =
-w "${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.com/multipath-tcp/mptcp-upstream-virt=
me-docker


Please note that despite all the efforts that have been already=
 done to have a
stable tests suite when executed on a public CI like here, =
it is possible some
reported issues are not due to your modifications. =
Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
