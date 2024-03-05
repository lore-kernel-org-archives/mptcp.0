Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223881DFF8
	for <mptcp@lists.linux.dev>; Tue,  5 Mar 2024 14:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709650752; cv=none; b=TrkThl5YDRnfX1FG2RuoQk/nN7nxx+8jVn0XYh8qRVxhHsj39AXRYT/n12tvD4GCrM5XekaQDd4UtDB2jrFZAIngqZIxf5+wQ1wGsiAgiCLZ3cbnWItqrG3dhady+tPX/4PsENQn4JpGAjGaIeVLJ+W1UZcAbHrRxeE/hmXNq40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709650752; c=relaxed/simple;
	bh=Hngfi+CAXiNrcXceh2C1b6yDvplS2yF2RlyQbeFBTQY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=kwkpi7aVtvNVREL5lfRuEzMdx3j4XdgGBfJSyJ8QyDwqvLhuSzU2oFYOFmcENr7A4svUvnhsj/mnDFjl59OX7JWpQyq9LlQsvVVQwZTct4A8uhZ7/zcQbzQIpTJ5hdniyTQaY1LiZN28wCjyDa/sTaJjIGvqtedzU04l9x5PgEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ggdg66LH; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ggdg66LH"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7d130979108so3095870241.1
        for <mptcp@lists.linux.dev>; Tue, 05 Mar 2024 06:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709650749; x=1710255549; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5JJjw6iOCxmpqkhL7zjIz+YinqxDuuC+hLQsWLITzK8=;
        b=Ggdg66LHP1JSLS86pP4w0u7j/ZStWoe27SY/4zzmspzsRXt67sjtUngqOxjVQBznIm
         qo0pvH1o8vGqSDklXHdQC7YnLKw1ILUvUB68e9aOnyzIq15RsODLDNUplp0tbfUZUhZd
         HW5ajJ6OvieKqeZ4P4DsJqWJ/OEUMzMSdplF4S+m/L14P4A+dupprLos6w9mom2kSiFZ
         S7sw5KCgbYsSX4VZ1E9vIEXcunHrUXyAHrVU+FRq1t/jYt0acJqkXbNSnGioNnfkXQTR
         dms6r3FwNKHTKVvQ8TmH4fHKAKNm5xahaunT4zLvXdcIOVZh2MBeSsN/CFqKVzOFiQbe
         UXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709650749; x=1710255549;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5JJjw6iOCxmpqkhL7zjIz+YinqxDuuC+hLQsWLITzK8=;
        b=vlRT0CBRatQaJ6fBNJ5D+DHOaExx55njR1gv02+xv63bho8g5BA3w9mSe33+GvRHqc
         BevQEEDcrCcojuoOkR8Y43ICL1nqVR8/QJ+geHGZJMlqX37L2p3MR8NPIgGfaFt0Ociq
         9eoCjE86nR3PJvQo4Mhl8JdI7wHpCu7bnQhL6RSx85W0gD8PNIxYMGNavQdjooEnJly4
         VBrOyBR/dbNC6FTClZ8XXy+zUuU3N87ggI2oxRDa9MMDYvI/hYyatW2VbzaEcJ4phHzv
         r2DrJV/P9gzvbc0vdDZPrEK9aGBII3VLK/x9ZsLpGnSUJNNRRxY5siFtdfoPuq6m9KP3
         jqUw==
X-Gm-Message-State: AOJu0YznJjhmJxu0PVQCABsS44U6CZI1YqzKsnhN0t0aa3QhRhDza37n
	qMsGXUbPyooVPped6aqToRVQVsYL/AkFoTgYvwRS68jj611oLK3m9Ah8KNQ=
X-Google-Smtp-Source: AGHT+IGfJ55EbLXPOX/PXSVGFObITFcf3GTKE/LlWBmArHcTABxXLJR+DpvopKNZRmoBZwYdCTd5HQ==
X-Received: by 2002:a67:fc07:0:b0:470:6a99:25dd with SMTP id o7-20020a67fc07000000b004706a9925ddmr2115731vsq.17.1709650748875;
        Tue, 05 Mar 2024 06:59:08 -0800 (PST)
Received: from [127.0.0.1] ([40.76.119.1])
        by smtp.gmail.com with ESMTPSA id e8-20020ac84e48000000b0042edc381599sm3343772qtw.1.2024.03.05.06.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 06:59:08 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Davide Caratti <dcaratti@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <cf0fb6eb68466bef37d685cc8a52cad3b69c4e7a.1709647631.git.dcaratti@redhat.com>
References:
 <cf0fb6eb68466bef37d685cc8a52cad3b69c4e7a.1709647631.git.dcaratti@redhat.com>
Subject: Re: mptcp: don't account accept() of non-MPC client as fallback to
 TCP: Tests Results
Message-ID: <5cc4bcf2-12ac-d1e0-b794-2b612cfbbecc@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 Mar 2024 14:59:07 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Davide,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/8157811382

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/e08e8f186d4d


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

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
Bot operated by Matthieu Baerts (NGI0 Core)
