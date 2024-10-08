Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3471217332
	for <mptcp@lists.linux.dev>; Tue,  8 Oct 2024 22:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728427389; cv=none; b=dires5QsuPM10gB03xeuOxLjuK9RFpCEwZDrfyMTOmCA/2RrbYwrU9Uy6JwywWrwLRhdZJUJOAMkklCGGfDqEu5Gb5Yyq3o7bZu6x4C608t5LxIX3+FNqiLKGN2UFnoUTKrhwBVpDAKolyRD6JXMnKlAlN+F1yRHouTxNgnsFLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728427389; c=relaxed/simple;
	bh=3KRS0ADRKZiQzCwW71BgRhBPnrmh8ivmq1Yerlo7euA=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=n3a1BwRI8lBkNb5GUBV1icWkVnzzFdzAktNHM9Doh0haHkyb4ep/LA6NBJgH5UUSz7OudBoJ15FpE4OHJsGQMdmYXKzRgc5olj5UwBRsquDVTVZHK1wTW9+NCFuzRDm0EDXsYKYTYaHetY6X0og4ycF8xDOXkvb3hrYD3qIoBcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eg3AeNqI; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eg3AeNqI"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-45ee18f058eso8216361cf.1
        for <mptcp@lists.linux.dev>; Tue, 08 Oct 2024 15:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728427387; x=1729032187; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqmoIOOC/kd0EWZE/M4cvrAxOHOjdO4tByugXuFaoPY=;
        b=eg3AeNqIKGVFGQaDcCnG8alTfdDJlskUCfXJ7PTaIPnvzaG5hIgzanTgw4J7dOXZeO
         YCVaqZ1xjVotvtmb0FjSGtTAtll7KBNYSb1aga+6Run5djwasN+6RbWupyruKriEcAOc
         Q0BwgaJ4AUtwkYMFjYe8Gg4Fjocr3KIWVQV+FOk+qE2+qK87GdBrxaAeKMBfUp1oGd7e
         QFTbbLe6bYK0vezpyf8XqQAgWbPoVWI2NoEb4UBhj8qNHHimkU6yCrC81Gnzyzs4DuMP
         /CNAJd5wWLl0Cieh9VdIlBhjGBu6VBTFf+EFsCPKt7m7XuGmjWBbGz1jPVnkLY+2Y7y+
         OHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728427387; x=1729032187;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xqmoIOOC/kd0EWZE/M4cvrAxOHOjdO4tByugXuFaoPY=;
        b=rMBLVAyG1w7qSxW3OcSUyyXESJFTNvj9d4xErIX2TxWbH3gc8ZF7AiDd4a0pJs33RK
         c6/REBM3T/frsM6CrDSXERCoTV3AE84/KK37ROQWtYfjwpJVEahjYc2avLqYGDCe20b7
         796O9dr94mjtzDN9lGj6kP8JKY6jFMZQ/yXUnLnjs2tZgsA+q69XkpLcPPYUaCIhBIFs
         Fe8/34i4a2/l0mLcaBgO9b9uXP0hd200qqunM2fUUjWcNnyKggstP4qjOQe494/GXcTA
         qp5r+ooj2KaF1svD/Mq+6aaMKjM+yFVex9luws8TP0o/CRFgFnMD3sDDuzBYVEXCC1zc
         Xduw==
X-Gm-Message-State: AOJu0YzFHZovjoVKaPuHjJyxrqu09rM1RGCZgkVrka8XjVNXHXSZzxmV
	6EINMxSwHlBIZk/uhc6bYnli9+lISINdBMFWSec9bnkxzp7A6WY=
X-Google-Smtp-Source: AGHT+IGwNl/vUdeRAVD8R2KEzibifDnlfYDJw+n4fQ0/td3zVJTVCHqR7MJ4C/gC7gVdPfMUleycEg==
X-Received: by 2002:a05:622a:259b:b0:456:87c1:59c7 with SMTP id d75a77b69052e-45fb0e768f4mr6987021cf.57.1728427386788;
        Tue, 08 Oct 2024 15:43:06 -0700 (PDT)
Received: from [127.0.0.1] ([20.57.14.22])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45da7555ad5sm40725751cf.43.2024.10.08.15.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 15:43:05 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Davide Caratti <dcaratti@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <4b2cee91613e597a172b46bb0d9d3143053c52da.1728408247.git.dcaratti@redhat.com>
References:
 <4b2cee91613e597a172b46bb0d9d3143053c52da.1728408247.git.dcaratti@redhat.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next=5D_mptcp=3A_us?=
 =?UTF-8?Q?e_=22middlebox_interference=22_for_MP=5F?=
 =?UTF-8?Q?TCPRST_in_case_map=5Fvalid_is_false?=
Message-ID: <7220baa2-4c0c-001a-db14-490ed48aeceb@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Oct 2024 22:43:04 +0000
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
uns/11240855539

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/184902b101dc
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D896827


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
