Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE187B
	for <mptcp@lists.linux.dev>; Fri,  6 Jan 2023 06:34:34 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id gh17so1576736ejb.6
        for <mptcp@lists.linux.dev>; Thu, 05 Jan 2023 22:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMfQymO3cmOwB7oFKXbZfXhUdUu3aW0fMLT5d+QztAQ=;
        b=HhSJqYQrVpmC/4JZc53fusJClGep7la2k40nEBjd/4oBu5ACNDAmG9hiugmMf6ACeL
         HFfikGWmyTTOVuAbReiSPkYwE7AbV+zWq61k1bXthrrFgvOIndaC+5X81mX40/Q7OrUU
         PhI8oCplwuj3LwemsouMiy+BI+X14iDQEMs8SI280Cj0c1okQBvQ5yyisnyFtpsgJbXR
         4RYsBrQwKSqbTkGd50Eb2WM46izfAIrHcdNYCLl/o1B8Sj2Qc0ha221aOlmPq6pnQKLR
         aTBn2dvhUBEj1ZGZOkAzQ4ZJxkjKOZeNGabIZHjepg+iURUX2I7fv1XOef8vu9jZOcsw
         AYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OMfQymO3cmOwB7oFKXbZfXhUdUu3aW0fMLT5d+QztAQ=;
        b=Z3LL80s2XHrQjS+5wWkavagNDRjgt9LV0o2s+p1ZEauoTnUu7ez5Rv/3lv5w2p2LYJ
         ZTXoezlRJM+AR16qK//RuQxpFXh882ZdLYzEDM+oKDHOIp35ClMHaBELxpqkrGsG3pnK
         9q1gXdGQovpppRF6X2NzyWeHYNoc7sgxS9I7pgSVACBiFGcBUWDlibS5RkD7Qep6HOII
         NUCRtZ6Tza8tPF79WOPXe8gk42IKBZAirySwnpUAX1a7XqewgByAfF/hJ+X6Low6eyMW
         sa3WBhCsPc1jMAvSECoKJHhwisD5lWh2kukc8EVXUE+lFYtuiRc5gRIabJNXdY8WYwux
         y12A==
X-Gm-Message-State: AFqh2kpTEZ6+qalwm9hdvQNIZn+rYA9UXFiggqqNfz220bNbhez9kE4w
	q5CEq1u8bv8DYXU4sndtcVRMVQ==
X-Google-Smtp-Source: AMrXdXt6xvJWzGKFU7vUi9pv/3yKxmFhZYvb0VC0PqqtZU4Gt0/2pNDq0oAg7tm7bAqZqc0lIYzKeQ==
X-Received: by 2002:a17:907:8c0c:b0:7c1:1901:a445 with SMTP id ta12-20020a1709078c0c00b007c11901a445mr47812796ejc.20.1672986872918;
        Thu, 05 Jan 2023 22:34:32 -0800 (PST)
Received: from [127.0.0.1] ([194.110.115.77])
        by smtp.gmail.com with ESMTPSA id lb24-20020a170907785800b008448d273670sm106061ejc.49.2023.01.05.22.34.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 22:34:32 -0800 (PST)
Date: Fri, 6 Jan 2023 07:34:32 +0100 (GMT+01:00)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Message-ID: <bfae082b-18a5-4c15-8bdd-d9a34516d5f7@tessares.net>
In-Reply-To: <a684ae0c-060c-49ae-f3a4-ec0a26dd0e21@linux.intel.com>
References: <20230104171526.1416746-1-matthieu.baerts@tessares.net> <20230104171526.1416746-10-matthieu.baerts@tessares.net> <a684ae0c-060c-49ae-f3a4-ec0a26dd0e21@linux.intel.com>
Subject: Re: [PATCH mptcp-next v5 09/12] selftests: mptcp: userspace: print
 titles
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <bfae082b-18a5-4c15-8bdd-d9a34516d5f7@tessares.net>

Hi Mat,

Thank you for the review!

6 Jan 2023 02:19:26 Mat Martineau <mathew.j.martineau@linux.intel.com>:

> On Wed, 4 Jan 2023, Matthieu Baerts wrote:
>
>> This script is running a few tests after having setup the environment.
>>
>> Printing titles helps understand what is being tested.
>>
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>> ---
>>
>> Notes:
>> =C2=A0=C2=A0 v3->v4:
>> =C2=A0=C2=A0=C2=A0=C2=A0 - Add a title for the Cleanup (+ 'Done' at the =
end)
>>
>> .../selftests/net/mptcp/userspace_pm.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 24 ++++++++++++++++++-
>> 1 file changed, 23 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/t=
esting/selftests/net/mptcp/userspace_pm.sh
>> index ab2d581f28a1..f9a03e6e968f 100755
>> --- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
>> +++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
>> @@ -43,6 +43,11 @@ rndh=3D$(printf %x "$sec")-$(mktemp -u XXXXXX)
>> ns1=3D"ns1-$rndh"
>> ns2=3D"ns2-$rndh"
>>
>> +print_title()
>> +{
>> +=C2=A0=C2=A0 stdbuf -o0 -e0 printf "\t%s:\n" "${1}"
>
> The indented titles seem kind of inverted to me:
>
> """
> =C2=A0=C2=A0=C2=A0 Init:
> Created network namespaces ns1, ns2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 [OK]
> =C2=A0=C2=A0=C2=A0 Make connections:
> Established IPv4 MPTCP Connection ns2 =3D> ns1=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [OK]
> Established IPv6 MPTCP Connection ns2 =3D> ns1=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [OK]
> =C2=A0=C2=A0=C2=A0 Announce tests:
> ADD_ADDR 10.0.2.2 (ns2) =3D> ns1, invalid token=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [OK]
> ADD_ADDR id:55 10.0.2.2 (ns2) =3D> ns1, reuse port=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 [OK]
> ...
> """
>
> It would read better to have the titles left-justified and the test resul=
ts indented, but that makes all of the test results extra long. Seems like =
you are trying to avoid that (for good reason!).

Indeed :)

> What do you think about copying the "INFO: ..." style from mptcp_connect.=
sh?

Good idea, that works for me!

I can do the modification (s/\t/INFO: /) when applying the patches if that'=
s OK for you (if there is nothing else to change of course).

Cheers,
Matt
--
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
