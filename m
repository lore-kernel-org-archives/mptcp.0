Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BFE3BB24
	for <mptcp@lists.linux.dev>; Wed, 20 Mar 2024 09:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710926804; cv=none; b=tXQt1kniJpR9/c8Fkv+pcvK35Dgy9qKnf/IYsng9pcbBWUK2pUwLo2ySzK0sj6zw8azC9ef4eU0nNdr8/DB8afUfeHzWRGp001qK0DUZI52wlaB+rcBCrfpRZKYDCBCdeV9u/1KCndr0/oTiGrENBickeoSywHR26ksUWBdSPqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710926804; c=relaxed/simple;
	bh=TE4kaGXViaKmqyrrqeBEPLSNd2jK7mFBJjCmlS+lmfI=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=YaJBqXjTMokhyqGvjBxccDvqxTj8W2+2N1tj3suKq6r1nTFriVDbIQKiuU2AdMuIP0mWAkkq76R8rge9KlnMwV+kIjvQqMKtPAaXKvSh5uRaun5v/s+OmUUKcRzxRmMJjt67wbWMa0fX//WcOEC7YEyAweB+xdYBmtTfEYfE2oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYX8txGM; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYX8txGM"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso4190165a12.0
        for <mptcp@lists.linux.dev>; Wed, 20 Mar 2024 02:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710926802; x=1711531602; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSDwRl0NM4LnsMl4nUG21EZNY0XHGJadOrWChgDPBRg=;
        b=NYX8txGMTiUFZfgDuhS5qx1zXSEIP38vrMbISWHcjBhQL6zRE0vDEc8W7fLNX+Ww7a
         roJn5/5B8GIXjaK9A4i2t+A2FZZ4D2KnBMCDxW2Y0u1ViCSUuZ0E4Pg9TQtC9DJFk5cl
         ydTngebOemcij9QWmuMUtJwi2NB6ES9cKHFOjEIK3vAdMsWLYnKqI4QyzDY9px8Am+vj
         AuAI2HnBH5PX7HZUukwi9PaKR34rij+FErT2c3eX9Q9bXZ7vf7GirrBsFxBpNlkpBQQ5
         AJOEZOS2sMyz8NLyjncp31hQgd3vO6QYO1i1VwQ6ohoSwVLt3oIX5/anGc0QqnVRwvVC
         8GRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710926802; x=1711531602;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BSDwRl0NM4LnsMl4nUG21EZNY0XHGJadOrWChgDPBRg=;
        b=JFFyE7+6Up4WKdqg9ctvFPWtWP7KyQIO+mWcvgxRkA9z7msx9gJl5RH2coZ+O1nRQq
         kEyZeNoWNILFpKzsCVBmdYqULMUwBqxWLV5GGi9VKBpP3QJptKeTHBZn/EtbjueK91Xh
         WDRDi0UEiszTV5iUfBd9zvXywh8zMBKUA0IHFigkF1FNztkWimeyoqL8wWvc8PmzeJo+
         7UrmSH6mJj8DXHMBDdL2txKVhkH0P0YGxg9lZeXMumLrr4FaVOt7IAQipN2qsWhrK+sC
         DbBUfsnGTDinQ0uyVRStHEXkAWERaE2v/I/ZdNm5U8xXRAJnvkM4AYz6uwqFJkSz4zwH
         sa2g==
X-Gm-Message-State: AOJu0YwtYfltusae4x+3zBH/ZINimXUsb+FnIv6nakLzI7T7MY09hCFB
	GatNYx3Jw5AGHnMUcgdZEkhLzlTl7EM3zh4UxqLjLUlcB9hM1MU=
X-Google-Smtp-Source: AGHT+IEn4iUK7WiIGt1KvcnHn/IUXwAWLP9BtFeN0kxPYPXpOik/5SwLjFjXavUQTsGqx79d5hn63A==
X-Received: by 2002:a05:6a20:7f83:b0:1a3:7e87:970 with SMTP id d3-20020a056a207f8300b001a37e870970mr1617284pzj.37.1710926801860;
        Wed, 20 Mar 2024 02:26:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.91.68.162])
        by smtp.gmail.com with ESMTPSA id l14-20020a170903244e00b001dd922cbb58sm5543524pls.62.2024.03.20.02.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 02:26:40 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Davide Caratti <dcaratti@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <054bcffde84b87f588f788b30dce2b702a532f64.1710923679.git.dcaratti@redhat.com>
References:
 <054bcffde84b87f588f788b30dce2b702a532f64.1710923679.git.dcaratti@redhat.com>
Subject: Re: [PATCH mptcp-net v4] mptcp: don't account accept() of non-MPC
 client as fallback to TCP
Message-ID: <d75c8f2e-c4bc-0626-7b55-a4fef92a54fb@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 Mar 2024 09:26:40 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Davide,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/8356108624

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/3f2f029027a3
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D836672


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
