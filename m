Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3A4279358
	for <mptcp@lists.linux.dev>; Tue, 11 Nov 2025 06:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762843988; cv=none; b=qsagdKgY/0VT/1YZK5sX2uJQb1/GbmQ6CRgd9ReDspy5v2KpvZ2EqG4IPE7xRwJdZzYKZ4s3Pgo65xTFB9u9Jb61RB8uOO5TUmaOdqvkS4drQ0SXwGcLbuVHDgvrpBy97VOgFM71nkWBqYZv5JBp7dPpNSYO8oFQfKXBfyp4EdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762843988; c=relaxed/simple;
	bh=wawd7F/O+8DshP7oLpblaPOb2vT0UVSGGKlVO10/SMM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=EC8GyjtZzotVV0gdtkge10Dpok/lGRk/dMzuguMArtrize4mZ5M1LXvifJYQcH5UK3ArWlczrLvrMrVAksuXrhm6qV2XYI6a1Ymg/OFPpfs5W8u4ENXtvehhtHSktrRzy/sDWjvMBx87LPyG+ZoojtrYFHuhLbqU02a5ceJ90dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCLtdS9g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCLtdS9g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BEDAC116B1;
	Tue, 11 Nov 2025 06:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762843988;
	bh=wawd7F/O+8DshP7oLpblaPOb2vT0UVSGGKlVO10/SMM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=SCLtdS9g8sK2Fl2X8QK6IiE5nPpOShrLGCV6g1ITfI5scBecZv2rZM8YRoIe4JOdQ
	 Zpp+Avymb7Jv3oU911WAtBsnmC4ZqkMF6+yi24mwv1pr+Di0vCpevAcfqzdfzb/Y/t
	 BgPQ3SgcKJpbrNYEusp9kks6Er9XYQNNc7TnHg7rHaITiV7cV5W2wV+U36Vf4dd8tZ
	 58kRw3R6HySG4VP3EVqURrPI5aFdBffQWZcHNmNkaZ9UjaI7sf/7nTxGhf8juBiaBz
	 ZUKrZ2wrP6AJDBmSvsYVhGrHxBSJSN3FU9JwfYAs6qurkLneRBQ6nm2cI9o5z6IQD2
	 GBhiyuWALMhzA==
Date: Tue, 11 Nov 2025 07:53:03 +0100 (GMT+01:00)
From: Matthieu Baerts <matttbe@kernel.org>
To: Geliang Tang <geliang@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
Message-ID: <894506e8-df54-4fb7-8337-c5fdc99ecb73@kernel.org>
In-Reply-To: <d5ef4083df02cc56e51170ec906eeaea78443c84.camel@kernel.org>
References: <20251108-slft-timeout-stats-v1-0-c2234d277318@kernel.org> <20251108-slft-timeout-stats-v1-1-c2234d277318@kernel.org> <d5ef4083df02cc56e51170ec906eeaea78443c84.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 1/4] selftests: mptcp: join: properly kill
 background tasks
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <894506e8-df54-4fb7-8337-c5fdc99ecb73@kernel.org>

Hi Geliang,

Thank you for the reviews.

11 Nov 2025 03:46:06 Geliang Tang <geliang@kernel.org>:

> Hi Matt,
>
> This for this fix.
>
> On Sat, 2025-11-08 at 15:20 +0100, Matthieu Baerts (NGI0) wrote:
>> The 'run_tests' function is executed in the background, but killing
>> its
>> associated PID would not kill the children tasks running in the
>> background.
>>
>> To properly kill all background tasks, 'kill -- -PID' could be used,
>> but
>> this requires kill from procps-ng. Instead, all children tasks are
>> listed using 'ps', and 'kill' is called with all PIDs of this group.

(...)

>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
>> b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
>> index ce6c92826be7..91ec75ddcb96 100644
>> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
>> @@ -359,6 +359,27 @@ mptcp_lib_kill_wait() {
>> =C2=A0=C2=A0=C2=A0 wait "${1}" 2>/dev/null
>> =C2=A0}
>> =C2=A0
>> +# $1: PID
>> +mptcp_lib_pid_list_children() {
>> +=C2=A0=C2=A0 local curr=3D"${1}"
>> +=C2=A0=C2=A0 # evoke 'ps' only once
>> +=C2=A0=C2=A0 local pids=3D"${2:-"$(ps o pid,ppid)"}"
>> +
>> +=C2=A0=C2=A0 echo "${curr}"
>> +
>> +=C2=A0=C2=A0 local pid
>> +=C2=A0=C2=A0 for pid in $(echo "${pids}" | awk "\$2 =3D=3D ${curr} { pr=
int
>> \$1 }"); do
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mptcp_lib_pid_list_children "${pid=
}" "${pids}"
>
> To be honest, I don't understand why this mptcp_lib_pid_list_children
> function is calling itself here. Is this recursion?

Yes it is a recursion: children processes can have children ones.

mptcp_lib_pid_list_children() will print the PID it is called with, and cal=
l
itself with all children (can be none).

In our case with mptcp_join.sh, it means getting the run_tests job plus
the other background tasks: mptcp_connect (x2), the timeout, and
eventually the task modifying the endpoints.

Cheers,
Matt
