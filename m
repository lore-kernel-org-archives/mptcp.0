Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B6619D085
	for <mptcp@lists.linux.dev>; Tue, 13 Aug 2024 14:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723559263; cv=none; b=CvXbGnjgS7fVqpEuNG8Gzii7Al9Nm0+6WRe0624JMocNTlOSyjsTkbIUqUUg/nedDVOcrErp9vkrFyCCjuZFZxXwdXB7ZfioRrKPOTS+KNiaTfps3tWo3JL67biLMYIWEzFOGNXxVwbYIHzLwJ2bCQdjhe//JTPajc5vAXF4Ty8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723559263; c=relaxed/simple;
	bh=pl7XDfmlgkJTQ3Wsi8LAJgjSYbTby4Nh5rH94t5YTr8=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=MZvKbr4bq4lWtyM8p3z4HkaIzWf32vHb9lmZCkuphqqyke8/0Nbl4q2311uf8GB+0LzI3cLhgD9jZ7pPESwW8UFASckRnHO5DXz687hVRwUsWM1bucXPhagMf96BtTZA6ZxIaEK765dqwd3fnmvklG/Vk1bLUBgd/FxA5400mXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XwyFhdT0; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwyFhdT0"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7bcf8077742so3973326a12.0
        for <mptcp@lists.linux.dev>; Tue, 13 Aug 2024 07:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723559262; x=1724164062; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcHHG4veYse2P4tUHMh2/VTcVFRgWtQpITQlpDVUOHA=;
        b=XwyFhdT0WMkm6XvrA8+tbRIxEhUNjmPwJvUOH/y60l/k/Whsw/BiiIJFH8G122xM17
         L4NeKU5rAOZEFN/q63PfTOtVBkRBQR3htuCS7daS4eab24CvaKzM8YWcal6zTide35Ky
         R+9H7nSA7YKXWLA0Y7fAjtHH5UIoPI3hs+6SL06qVqt7/bJlgwNZOAjiAeCA9ukvt1GR
         AeISvSvP05q4Y89WXyg8bE7uXmfJ1IMfkcI5kAdkaRBS1UJ9mUQqOHADtgQTP+BH/qWU
         ttyCUt1e8NfSlOLqWhCOMjzBvXIMU6vgDu4caRr1TSVMdyKmGL+JHCQU9f6H8EnQbXa2
         vJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723559262; x=1724164062;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xcHHG4veYse2P4tUHMh2/VTcVFRgWtQpITQlpDVUOHA=;
        b=Q82eHySRY9CFZepc4tCTVzgd3XBAiHqgv9mfm4nx3qw6QJGcATlmzhzfkh1MhV4xUU
         6+2l771QC/BhHmhtraVHX8ywo6Sm5Qj/1Nsz73lC0ZpnVdOHtZZOAg+QuiF78siYFwuv
         PGF3oXVaTdg/h/zmtgTmEfX8Y2j2wLU/EdboeanFUVx/05uUl6HrGslMy8IiuQfRoa1p
         Jy1FBdiNMCjgOustIYokdBEpU6MDbiQYJZdO07BMVPUcg2TwRSMh3A/8xrEpz/FMHE0g
         WKied4VhAQFlz527vjosGtFUG6dgg9KFwV1ZOzK3v3ycJnayO1hjmxNUPHExQGIvd/UD
         MGrw==
X-Gm-Message-State: AOJu0Yz3M7v+vl1HRvkJa/wQGiLD14ko9cuNblWGGk9yADkMGNptXus/
	MlSM4za8D3MTIdbsKQGFZhiZQTMP80v6HZsOLqU7YrnYXpnAu7w=
X-Google-Smtp-Source: AGHT+IGrri1fLwcpcFiGVxPpCQaJos/nuXN53rdZrqRNKV+A9DItdabpYkK9cHk7BMDoBq7WDgDR5A==
X-Received: by 2002:a05:6a20:d522:b0:1c4:244c:ebc2 with SMTP id adf61e73a8af0-1c8d74e3ef3mr4165683637.30.1723559261588;
        Tue, 13 Aug 2024 07:27:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.123.127])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c697a6c464sm1525098a12.76.2024.08.13.07.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 07:27:41 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240813-mptcp-pr_debug_n-v1-1-ab706c0cbe60@kernel.org>
References: <20240813-mptcp-pr_debug_n-v1-1-ab706c0cbe60@kernel.org>
Subject: Re: [PATCH mptcp-net] mptcp: pr_debug: add missing \n at the end
Message-ID: <627f9b9f-fcfc-6389-638d-2fcc793f33ad@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Aug 2024 14:27:40 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/10371021606

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/c11571050cb9
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D879230


If there are some issues, you can reproduce them using the same =
environment as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
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
