Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C25B1B86E5
	for <mptcp@lists.linux.dev>; Sun, 28 Jul 2024 04:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722141643; cv=none; b=hsqBU+Vs4cwR+V9mrjE+rqTEX88AJF/dwq2RyvbFE5n8zkPizL8CJSK4GjV8xGUDo3DOIQQve0a/qKepqPxAVgVXpLFbn2MHoYxxdBwUe0V7PqM2kWN7qcJVzZ9hIKr+eYL4BHNXgtQuWFWBPKN19KsMU1GYDklBwURH0dW2UiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722141643; c=relaxed/simple;
	bh=u6yzCUWPEdfU51ME5EzZNJq/MZ17nc/qwRbElblr7x0=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=mdAyJpRLPZeOwe87ncE2yVfM1xoCIa5ivTBRMpTTJJylAfT1KEGNhklb+sX1CxEkCC+di00TtxjpcvvtmVCm3l94HGUvAPusISKgJTk2zZhpl0KAjajGe5Zp9Pfmbuuqa+IP42ZGS7olnqlAsNKF+uM7eccvZjKBJ2pD4UHOQkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P11vP6KS; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P11vP6KS"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6510c0c8e29so9402677b3.0
        for <mptcp@lists.linux.dev>; Sat, 27 Jul 2024 21:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722141641; x=1722746441; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=md3rHROHhm5592sLPbQQBsjndPbFrnk6cb1BeV5N5Mc=;
        b=P11vP6KS2GyTeJWnQuS5qZMnIYjr5RzPmeLBIz51ui2qr6S4k4vzwAjChTS18mEcMo
         iW1phtyjo7p/aGfp5FQhH9hoZyrHQGWPckrw6uJRmMoUWR0bmVMbCmuE8NVoQhZ3HX1+
         Ju/qBZtitElLKQC+5d3O05Xgmlycd28qZOOYl0UN6Dv0mQqs+Y1OrWr5iXJVdwl23Gfz
         UUVrAy6hCCs4VLkelrPYf9+W8JTrxbr6Pzo6utn6NlqQW/JHxwbS+eh4jZW0xKuI6tuf
         Y9q7mCh3AVzlg37l5v74Xk19uiUsPQKaCL90Seqf1y5omfW+j+XeKppTMiERtfWVsOqQ
         fEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722141641; x=1722746441;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=md3rHROHhm5592sLPbQQBsjndPbFrnk6cb1BeV5N5Mc=;
        b=bdo5jbn1SME/1GsoKZphpEcaSfb396H1DwaNDlhDqfz4HCfiv996VNEAT51dY17V2V
         I9MiobEZNotnw2wPDFkNYYVH1FLAJhPF5SKlrgzdOpSgjOrxsG4UKBGtq+IatvOWgXEu
         URz1ZZehWv21b0gLt1TZZkDRRUAmmWJ0BFlqEn4ZHBzKmQ5EwpP4ldzZD85JTIROiXua
         +iRGyC8R8ucJ+BccXoU1YsKPFW8icXkFZsJ92LUGdFbqhS1Z304iJ7Udxqb3uiluEnsI
         gMgJdT5nIUNZ9iAvhCiuJMPx2nLIMP1BZbRDO0t0AWVobyVBcx1TyERB9qXT1gLUZKqM
         SnJg==
X-Gm-Message-State: AOJu0Yz/7SOunacqoViYn/6yfrGIxjSShlC+Vc2OcOs5CdJSgtmdg/mM
	7dX2zsn/oHfggz7VarCW6VWPCGUIO+A/+SWYatzAEPvuxnyZuis=
X-Google-Smtp-Source: AGHT+IF1gRq2d4IHGAn60a2Im5jPfZT1tJZP1plwZcMgPiobIdJJq6TdBP05pF9RPWdAKDTWE9yf1A==
X-Received: by 2002:a81:9c50:0:b0:65f:ca0b:451c with SMTP id 00721157ae682-67a0769aa44mr48580577b3.21.1722141640872;
        Sat, 27 Jul 2024 21:40:40 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.121.87])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756bab4a76sm15224387b3.123.2024.07.27.21.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 21:40:40 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <1a05890e3e65de00b45b2453232eed12fe55ad14.1722138313.git.tanggeliang@kylinos.cn>
References:
 <1a05890e3e65de00b45b2453232eed12fe55ad14.1722138313.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next] selftests: mptcp: join: simplify
 checksum_tests
Message-ID: <e135107b-e3d2-5c83-223a-a6a82290056e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jul 2024 04:40:39 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/10128798562

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/ca671f006b59
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D874288


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
