Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1154D202C58
	for <mptcp@lists.linux.dev>; Sun,  3 Aug 2025 07:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754206558; cv=none; b=UX1LnASVXhjJdxGdnMV4RT6Yj90bHwLYrnghLScdMmii6t3Zu1ajIPXBSmMU2tnqwUUFDto1YA2Z0bZLH1oEvRpPYJ8Fs+PDYRAbF6OR8J+27TUeuWPWwxTuOC0qTeJwP8TkvAFZbI1t4TJXReOp5J++QDHNhiRsUQtjbVApZ7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754206558; c=relaxed/simple;
	bh=faQHfkmiPEAiUVtsRZSX9J9EJcX7lXd9tlgAHSLH5cA=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=UqjdygRsiWISezQsWF8MB/JlnoBn36H2CNDqV9axaNzrmDhBEq7TKT/XOXkb2m9eLHxmGHHDwEiePHZ0EA8IT0RldJxhNZY3TMl+UzFbai5/+W7VzzzDJ8aJagiNN8sivPyKVUDHA4zVtSCeAVXTLsmbZw02vV3I/PyQ1icZ6mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1dVz9FV; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1dVz9FV"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b0619a353dso1726561cf.3
        for <mptcp@lists.linux.dev>; Sun, 03 Aug 2025 00:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754206556; x=1754811356; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRBdte+2I3rW/RakYb6GpQpHDq3dVEGN/vzQ8Dk+zOo=;
        b=Z1dVz9FVbPgz0209KT3WbAk2AZfHFXLhfn3men7htME5a/4Uea3pjf9qTa+kZllXvo
         ij0IH1kUD4+NctAe6DdIO/yqp0YG7R+Jq5rEJ6uenuEGwQ5xu7I+MshbSVJHiVgEVJW/
         uEZ7lLc/rG3kr4qcI62N/TAD+f8YuaakfoRdw2Kq5NWP1gVSdohykBNx5MGxbcaMfsa0
         vNnaPl73zQJpaS9in9vW8RnJxMjnYHUBUMW/aiehtjt6h0OgwwEBCe9/3XqKh5s29GNk
         Eg9pw8JgY9yMVWAzHrD0yowgT1X9g2PKBGiFadqw83ma/bCYsUJec+GZFdztq8rqXNTa
         84GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754206556; x=1754811356;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PRBdte+2I3rW/RakYb6GpQpHDq3dVEGN/vzQ8Dk+zOo=;
        b=BQJ1T526evtUnGulvOZWIHY71x6+Fzsq+UAkmxWvSaWFORUZwIL5MUII9PyLtnAudU
         vAv2pZMSob21T8Um0tRlojdvB9FW4dk57wyXrgI4pEy8LTsZSiovVEPVEZ7lUAG15XyF
         Mt/2kYZAkGtnRKrpIGkXwUxdYulX8RpRlq0WFy/I0Z+M6TnAuBxGuahilgGuFEd/MsU2
         2fnm0CYCbilNzfEe1wSzTo90ZO6B//uEkMbaXOmDnUFhq5lyJjTom5cX93D1vJEWXxBx
         bKIxpRVtQVMR/XhFvDuj67mSWZRa/RuWUc8CL9KgBCLKR3s4diVIcXFFEnrzpxoXDET5
         ao8g==
X-Gm-Message-State: AOJu0YxgOrOxQBDTHro47Jx9KcVoaqJ1omaMv2UdDeDO/qHlTkqf0d+S
	yK2tT6r/x19LgFmUvkFaJVAz4+CtoeNOMm4ugf925OC8XA3JpniHq6i6Pd2TF7o=
X-Gm-Gg: ASbGncs72n5K5FPAQulOrXURmYUXW5PP91YCxYoHLV6JwqWKufn/qHPqwg6cRAkvMYO
	niS5UPdxpzT7BJPHNmsd9n8Rfl7fPO8pafxveBcPRXhhCMUZUMYUsUeatfm6xXwmVSqmil2lncO
	oUoUDQ5x/2m3fVQi+hiCB9E7SOefqjXLD45DbfxAI+LWj7vQbqRsPQp6bvA0h91ggTn4uPZdX1g
	I8r611MI2HOV4IUXxC3kqcaVJoIvNVB3T+sh5NvWVJwJSYYBR6g3PyRI2AjExrtYpmRcjJ4a4DA
	1r63ct0ADdaj0YX8voCsxk7OefbT04FzMbpSxmYJ1V3oknpHmFxLGqUOqUtIfGTgDu57ARd9UxX
	NbAaRJTkcDk74PTKJcPPhCWhluejXbufovA==
X-Google-Smtp-Source: AGHT+IFv2VgDJZSiR/TEYc3BOJp5fi/TOszVqDp9x7Xwab+mEXEEXfkuYm/YBVVigsRFTdum4Wp8rQ==
X-Received: by 2002:ac8:5a4e:0:b0:4ab:6e68:1181 with SMTP id d75a77b69052e-4af10d5d2a8mr72847691cf.40.1754206555650;
        Sun, 03 Aug 2025 00:35:55 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.28.96])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4aeeedab174sm39826721cf.44.2025.08.03.00.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 00:35:54 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1754126092.git.tanggeliang@kylinos.cn>
References: <cover.1754126092.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 0/3] mptcp: add more sockopts
Message-ID: <9f414f9b-e2eb-ab69-e3e6-8cedbe81207d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 Aug 2025 07:35:53 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://github.com/multipath-tcp/mptcp_=
net-next/actions/runs/16702556215

Status: failure
Initiator: Matthieu =
Baerts (NGI0)
Commits: https://github.com/multipath-tcp/mptcp_net-next/comm=
its/acf2cf2e5caf
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D987858

Feel free to reply to this email =
if you cannot access logs, if you need
some support to fix the error, if =
this doesn't seem to be caused by your
modifications or if the error is a =
false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu =
Baerts (NGI0 Core)
